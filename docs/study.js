/* CS 424 study. All measurements stay on this device until CSV download. */
const VERSION = "parking-calendar-v3";
const LIMIT = 180;
const RESULTS_FORM = "https://docs.google.com/forms/d/e/1FAIpQLSfPXXx88FNx5ncfrxbgFTQCwjNG0ufvBeP0s5E5kvs2L93WZQ/viewform";
const app = document.getElementById("app");
const data = window.PARKING;
const dates = [...new Set(data.map(r => r.date))].sort();
const months = [...new Set(dates.map(d => d.slice(0,7)))];
const dayNames = ["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"];
const questions = {
  T1A:{dates:["2026-10-07","2026-10-09"],text:"Compare the gym on October 7 and October 9, 2026. From the first recorded visit to the last recorded visit that day, which date had the larger increase in percentage available?"},
  T1B:{dates:["2026-10-12","2026-10-14"],text:"Compare the gym on October 12 and October 14, 2026. From the first recorded visit to the last recorded visit that day, which date had the larger increase in percentage available?"},
  T2A:{dates:["2026-10-22","2026-10-23"],text:"Compare school on October 22 and October 23, 2026. From the first recorded visit that day to the lowest recorded availability between 09:00 and 16:00 inclusive, which date had the larger decrease in percentage available?"},
  T2B:{dates:["2026-10-26","2026-10-27"],text:"Compare school on October 26 and October 27, 2026. From the first recorded visit that day to the lowest recorded availability between 09:00 and 16:00 inclusive, which date had the larger decrease in percentage available?"}
};
const allocations = [0,0,0,1,1,2,2,3,3,3];
const plans = [ ["Static","A","Interactive","B"], ["Static","B","Interactive","A"], ["Interactive","A","Static","B"], ["Interactive","B","Static","A"] ];
let state = null;
let activeDate = dates[0];
let activeMonth = months[0];
let clockTimer = null;
let submitting = false;

function esc(value){return String(value).replace(/[&<>"']/g,c=>({"&":"&amp;","<":"&lt;",">":"&gt;",'"':"&quot;","'":"&#39;"}[c]));}
function dateLabel(date, full=false){return new Date(date+"T12:00:00").toLocaleDateString("en-US",{month:full?"long":"short",day:"numeric",...(full?{weekday:"long",year:"numeric"}:{})});}
function weekday(date){return dayNames[new Date(date+"T12:00:00").getDay()];}
function groupFor(id){return id.startsWith("PILOT")?(id==="PILOT01"?0:3):allocations[Number(id.slice(1))-1];}
function trialPlan(id){const [first,a,second,b]=plans[groupFor(id)];return [{condition:first,task:"T1"+a},{condition:first,task:"T2"+a},{condition:second,task:"T1"+b},{condition:second,task:"T2"+b}];}
function key(){return VERSION+":"+state.id;}
function save(){try{localStorage.setItem(key(),JSON.stringify(state));return true;}catch{document.getElementById("save-error")?.remove();const p=document.createElement("p");p.id="save-error";p.className="error";p.textContent="Your browser could not save progress. Keep this page open and download your results before leaving.";app.prepend(p);return false;}}
function bind(id,event,fn){const element=document.getElementById(id);if(element)element.addEventListener(event,fn);}
function scrollToTop(){window.scrollTo(0,0);}
function note(){return `<p class="view-note">Dots = visits. Rings, inner to outer: 0%, 25%, 50%, 75%, 100% available. ×2 indicates coincident visits.<br>School: 06:00–20:00. Gym: 09:00–21:00. Matching angles represent different times between locations.<br>The bottom gap is outside the displayed time range; it does not represent missing observations.</p>`;}

// Use the same clock drawing in every condition and on every date.
function clock(rows,location){
 const visits=rows.filter(r=>r.location===location), start=location==="School"?6:9, finish=location==="School"?20:21;
 const color=location==="School"?"#2166ac":"#b35806", cx=260,cy=335,R=175;
 const point=(hour,radius)=>{const a=(-150+(hour-start)/(finish-start)*300)*Math.PI/180;return [cx+radius*Math.sin(a),cy-radius*Math.cos(a)];};
 const line=(x1,y1,x2,y2,color)=>`<line x1="${x1}" y1="${y1}" x2="${x2}" y2="${y2}" stroke="${color}"/>`;
 let svg=`<svg viewBox="0 0 520 610" role="img" aria-label="${location} availability clock, ${visits.length} recorded visits"><title>${location} parking by time of day</title><text x="260" y="34" text-anchor="middle" font-size="23" font-weight="700">${location} parking by time of day</text><text x="25" y="75" font-size="16">Rings, inner to outer:</text><text x="25" y="97" font-size="16">0%, 25%, 50%, 75%, 100%</text>`;
 for(let percent=0;percent<=100;percent+=25){const radius=R*(.25+.75*percent/100);let path="";for(let degree=-150;degree<=150;degree+=2){const a=degree*Math.PI/180;path+=(degree===-150?"M":"L")+(cx+radius*Math.sin(a))+","+(cy-radius*Math.cos(a))+" ";}svg+=`<path d="${path}" fill="none" stroke="#aab3be"/>`;}
 for(let hour=start;hour<=finish;hour++){const [x,y]=point(hour,R);if((hour-start)%2===0){const [ix,iy]=point(hour,R*.25);svg+=line(ix,iy,x,y,"#c3cad3");const [tx,ty]=point(hour,R*1.24);svg+=`<text x="${tx}" y="${ty+6}" text-anchor="middle" font-size="19">${String(hour).padStart(2,"0")}:00</text>`;}const [ix,iy]=point(hour,R*.94);svg+=line(ix,iy,x,y,"#626b77");}
 const groups=new Map();for(const r of visits){const k=r.time+"/"+r.percent;if(!groups.has(k))groups.set(k,[]);groups.get(k).push(r);}
 for(const group of groups.values()){const r=group[0],parts=r.time.split(":"),hour=Number(parts[0])+Number(parts[1])/60;const [x,y]=point(hour,R*(.25+.75*r.percent/100));svg+=`<circle cx="${x}" cy="${y}" r="4" fill="${color}" fill-opacity=".65"/>`;if(group.length>1)svg+=`<text x="${x+7}" y="${y+4}" font-size="15">×${group.length}</text>`;}
 svg+=`<text x="260" y="592" text-anchor="middle" font-size="17">${visits.length} visits</text></svg>`;
 return `<div class="clock-box">${svg}</div>`;
}
function clockPair(rows){return `<div class="clock-grid">${["School","Gym"].filter(loc=>rows.some(r=>r.location===loc)).map(loc=>clock(rows,loc)).join("")}</div>`;}
function details(rows){return `<details id="observation-table" class="observation-dropdown"><summary>Click to expand observation table</summary><div class="table-wrap"><table><thead><tr><th>Time</th><th>Location</th><th>Accessible</th><th>Inaccessible</th><th>Available (%)</th><th>Temperature (°F)</th></tr></thead><tbody>${rows.map(r=>`<tr><td>${r.time}</td><td>${r.location}</td><td>${r.accessible}</td><td>${r.inaccessible}</td><td>${r.percent.toFixed(1)}</td><td>${r.temperature}</td></tr>`).join("")}</tbody></table></div></details>`;}

function staticView(practice=false){
 const shown=practice?dates.slice(0,2):dates;
 let html=note()+(!practice?`<h2>All recorded visits</h2>${clockPair(data)}`:"")+`<h2>Visits by date</h2><nav class="date-index" aria-label="Jump to a date">${shown.map(d=>`<a href="#day-${d}">${dateLabel(d)}</a>`).join("")}</nav>`;
 html+=shown.map(d=>`<section class="date-section" id="day-${d}"><h3>${dateLabel(d,true)}</h3>${clockPair(data.filter(r=>r.date===d))}</section>`).join("");
 if(!practice){
  html+=`<h2>Additional weekday and temperature comparisons</h2>`;
  for(const warm of [false,true]){html+=`<h3>${warm?"70°F and above":"69°F and below"}</h3>`;for(const day of dayNames.slice(1)){const rows=data.filter(r=>weekday(r.date)===day && (r.temperature>=70)===warm);if(rows.length)html+=`<section class="date-section"><h3>${day}</h3>${clockPair(rows)}</section>`;}}
 }
 return html;
}
function interactiveView(){
 return note()+`<label for="month">Month</label><select id="month">${months.map(m=>`<option value="${m}" ${m===activeMonth?"selected":""}>${new Date(m+"-01T12:00:00").toLocaleDateString("en-US",{month:"long",year:"numeric"})}</option>`).join("")}</select><div id="calendar-content"></div>`;
}
function renderCalendar(practice=false){
 const container=document.getElementById("calendar-content");if(!container)return;
 const [year,month]=activeMonth.split("-").map(Number),first=new Date(year,month-1,1),last=new Date(year,month,0).getDate(),offset=(first.getDay()+6)%7;
 let html=`<div class="calendar">${["Mon","Tue","Wed","Thu","Fri","Sat","Sun"].map(d=>`<div class="calendar-heading">${d}</div>`).join("")}${"<div></div>".repeat(offset)}`;
 for(let day=1;day<=last;day++){const d=activeMonth+"-"+String(day).padStart(2,"0"),rows=data.filter(r=>r.date===d),school=rows.filter(r=>r.location==="School").length,gym=rows.length-school;
 html+=`<button type="button" data-date="${d}" class="${rows.length?"":"empty"}" aria-pressed="${d===activeDate}" aria-label="${dateLabel(d,true)}, ${rows.length} visits"><span class="day-number">${day}</span><span class="day-count">${rows.length?`School: ${school} · Gym: ${gym}`:"No visits"}</span></button>`;}
 const rows=data.filter(r=>r.date===activeDate);
 html+=`</div><h2>${dateLabel(activeDate,true)}</h2>${rows.length?clockPair(rows)+details(rows):`<p class="note">No parking observations were recorded on this date.</p>`}`;
 container.innerHTML=html;
 container.querySelectorAll("[data-date]").forEach(button=>button.addEventListener("click",()=>{activeDate=button.dataset.date;renderCalendar(practice);}));
 bind("observation-table","toggle",event=>{if(event.target.open && state.active && !practice){state.active.tableUsed=true;save();}});
}
function bindInteractive(practice=false){bind("month","change",event=>{activeMonth=event.target.value;activeDate=dates.find(d=>d.startsWith(activeMonth))||activeMonth+"-01";renderCalendar(practice);});renderCalendar(practice);}

function login(message=""){
 clearInterval(clockTimer);
 const supplied=new URLSearchParams(location.search).get("id")||"";
 app.innerHTML=`<section class="shell"><h1>Parking study</h1><p>Answer four timed questions using two parking views. Use a computer. At the end, copy your results and paste them into the submission form. Use your participant code only; do not include your name or email.</p><label for="code">Participant code</label><input id="code" type="text" value="${esc(supplied)}" placeholder="P01" autocomplete="off"><p class="error" role="alert">${esc(message)}</p><button id="begin">Continue</button></section>`;
 bind("begin","click",()=>{
  const id=document.getElementById("code").value.trim().toUpperCase();
  if(!/^(P0[1-9]|P10|PILOT0[12])$/.test(id)){login("Enter the participant code provided by the researcher.");return;}
  if(innerWidth<900){login("Please use a computer window at least 900 pixels wide, then maximize the browser and try again.");return;}
  let stored=null;try{stored=JSON.parse(localStorage.getItem(VERSION+":"+id));}catch{}
  state=stored||{id,phase:id.startsWith("PILOT")?"pilot":"main",version:VERSION,answers:[],active:null,withdrawn:false,viewport:innerWidth+"x"+innerHeight,userAgent:navigator.userAgent,created:new Date().toISOString()};
  save();render();
 });
}
function ready(){
 const index=state.answers.length,trial=trialPlan(state.id)[index],q=questions[trial.task];
 app.innerHTML=`<section class="shell narrow"><div class="eyebrow">Question ${index+1} of 4 · ${trial.condition}</div><h1>Question ${index+1}</h1><p class="lead">${q.text}</p><div class="note">Choose a date. Click Start task when ready. Time limit: 3 minutes.</div><div class="actions"><button class="primary" id="start">Start task</button><button class="text-button" id="withdraw">Stop participating</button></div></section>`;
 bind("start","click",()=>{state.active={position:index,started:Date.now(),tableUsed:false,focusLosses:0,refreshes:0};save();activeDate=dates[0];activeMonth=months[0];render();});
 bind("withdraw","click",withdraw);
}
function running(){
 const index=state.answers.length,trial=trialPlan(state.id)[index],q=questions[trial.task];
 app.innerHTML=`<div class="task-bar"><div class="task-heading"><strong>Question ${index+1} of 4 · ${trial.condition}</strong><span class="timer" id="timer" aria-label="Time remaining"></span></div><p class="question">${q.text}</p><form id="answer-form" class="answer-row"><label for="answer">Final answer</label><select id="answer" required><option value="">Choose a date</option>${q.dates.map(d=>`<option value="${d}">${dateLabel(d)}</option>`).join("")}</select><button class="primary" type="submit">Submit answer</button><button id="skip" type="button">Skip question</button><button id="withdraw" type="button" class="text-button">Stop participating</button></form></div><section class="viz-area">${trial.condition==="Static"?staticView():interactiveView()}</section>`;
 if(trial.condition==="Interactive")bindInteractive();
 bind("answer-form","submit",event=>{event.preventDefault();finish("completed",document.getElementById("answer").value);});
 bind("skip","click",()=>{if(confirm("Skip this question? It will be recorded as incomplete."))finish("skipped","");});
 bind("withdraw","click",withdraw);
 tick();clockTimer=setInterval(tick,250);
}
function tick(){if(!state?.active)return;const elapsed=(Date.now()-state.active.started)/1000;const left=Math.max(0,Math.ceil(LIMIT-elapsed));const el=document.getElementById("timer");if(el){el.textContent=Math.floor(left/60)+":"+String(left%60).padStart(2,"0");el.classList.toggle("urgent",left<=30);}if(elapsed>=LIMIT)finish("timeout","");}
function finish(status,answer){
 if(!state.active||submitting)return;submitting=true;
 const active=state.active,elapsed=Math.max(0,(Date.now()-active.started)/1000),trial=trialPlan(state.id)[state.answers.length];
 if(elapsed>=LIMIT){status="timeout";answer="";}
 state.answers.push({participant_id:state.id,phase:state.phase,study_version:VERSION,allocation_group:groupFor(state.id)+1,condition_order:trialPlan(state.id)[0].condition+" first",condition:trial.condition,task_id:trial.task,task_position:state.answers.length+1,answer,time_seconds:status==="timeout"?180:Math.round(elapsed*10)/10,status,table_used:active.tableUsed?1:0,focus_losses:active.focusLosses,refreshes:active.refreshes,viewport:state.viewport,started_at:new Date(active.started).toISOString(),finished_at:new Date().toISOString()});
 state.active=null;clearInterval(clockTimer);save();submitting=false;
 app.innerHTML=`<section class="shell narrow"><div class="eyebrow">Question ${state.answers.length} of 4</div><h1>${status==="timeout"?"Time limit reached.":"Response recorded."}</h1><p>${status==="timeout"?"This task was recorded as a timeout.":""}</p><button id="next" class="primary">${state.answers.length===4?"Finish and copy results":"Continue to next question"}</button></section>`;
 bind("next","click",render);scrollToTop();
}
function withdraw(){if(!confirm("Stop participating? You may download the responses already recorded."))return;if(state.active)finish("withdrawn","");state.withdrawn=true;save();render();}
function resultsCSV(){
 const columns=["participant_id","phase","study_version","allocation_group","condition_order","condition","task_id","task_position","answer","time_seconds","status","table_used","focus_losses","refreshes","viewport","started_at","finished_at"];
 const csv=[columns.join(","),...state.answers.map(r=>columns.map(k=>'"'+String(r[k]??"").replaceAll('"','""')+'"').join(","))].join("\r\n");
 return csv;
}
function download(){
 const csv=resultsCSV();
 const url=URL.createObjectURL(new Blob(["\ufeff"+csv],{type:"text/csv;charset=utf-8"}));const a=document.createElement("a");a.href=url;a.download=`parking-study-${state.id}.csv`;a.click();setTimeout(()=>URL.revokeObjectURL(url),1000);document.getElementById("download-note").textContent="Backup CSV download requested. To submit, copy your results and paste them into the form below.";
}
async function copyResults(){
 const box=document.getElementById("results-text");
 try{await navigator.clipboard.writeText(resultsCSV());document.getElementById("download-note").textContent="Results copied. Open the submission form and paste them into the results field.";}
 catch{box.hidden=false;box.value=resultsCSV();box.focus();box.select();document.getElementById("download-note").textContent="Copy the selected text, then paste it into the submission form.";}
}
function complete(){app.innerHTML=`<section class="shell narrow"><div class="eyebrow">${state.phase==="pilot"?"Pilot session":"Study session"} · ${state.id}</div><h1>${state.withdrawn?"Your session has ended.":"Finished."}</h1><p class="lead">${state.answers.length} of 4 responses recorded.</p><p>Copy your results, then paste them into the submission form and leave feedback. Nothing is submitted automatically.</p><button id="copy-results" class="primary">Copy my results</button><p id="download-note" class="status" aria-live="polite"></p><textarea id="results-text" aria-label="Results to copy" rows="8" style="width:100%" readonly hidden></textarea><p><a href="${RESULTS_FORM}" target="_blank" rel="noopener">Open results and feedback form</a></p><p>Use participant code ${state.id}. Do not include your name or email. No sign-in is required. Feedback is optional.</p><button id="download">Download backup CSV</button></section>`;bind("copy-results","click",copyResults);bind("download","click",download);}
function render(){clearInterval(clockTimer);scrollToTop();if(state.withdrawn||state.answers.length>=4)complete();else if(state.active)running();else ready();}
document.addEventListener("visibilitychange",()=>{if(document.hidden&&state?.active){state.active.focusLosses++;save();}});
window.addEventListener("beforeunload",()=>{if(state?.active){state.active.refreshes++;save();}});
login();
