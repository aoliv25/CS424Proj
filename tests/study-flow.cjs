// Software checks only. These are not participant or pilot measurements.
const fs = require('node:fs');
const vm = require('node:vm');
const assert = require('node:assert/strict');
const nodes = new Map();
function element(id) {
  if (!nodes.has(id)) nodes.set(id, {innerHTML:'',textContent:'',value:'',checked:true,
    className:'',classList:{toggle(){}},addEventListener(){},remove(){},prepend(){},querySelectorAll(){return []}});
  return nodes.get(id);
}
const storage = new Map();
const context = vm.createContext({
  console, URLSearchParams, Date, Map, Set, Blob, URL,
  innerWidth:1280, innerHeight:900, navigator:{userAgent:'software-test'},
  location:{search:'?id=P01'}, window:{scrollTo(){}},
  document:{getElementById:element,createElement:()=>element('created'),addEventListener(){}},
  localStorage:{getItem:k=>storage.get(k)||null,setItem:(k,v)=>storage.set(k,v)},
  setInterval:()=>0,clearInterval(){},setTimeout(){},confirm:()=>true
});
context.window.addEventListener=()=>{};
vm.runInContext(fs.readFileSync('docs/data.js','utf8'),context);
vm.runInContext(fs.readFileSync('docs/study.js','utf8'),context);
const run=s=>vm.runInContext(s,context);
assert.equal(run('data.length'),159);
for(let i=1;i<=10;i++) {
 const id='P'+String(i).padStart(2,'0');
 const plan=JSON.parse(run(`JSON.stringify(trialPlan('${id}'))`));
 assert.equal(plan.length,4);
 assert.equal(plan.filter(t=>t.condition==='Static').length,2);
 assert.equal(new Set(plan.map(t=>t.task)).size,4);
}
assert.equal(run("Array.from({length:10},(_,i)=>trialPlan('P'+String(i+1).padStart(2,'0'))[0].condition).filter(c=>c==='Static').length"),5);
run("state={id:'P01',phase:'main',answers:[],viewport:'1280x900',active:{started:Date.now()-181000,tableUsed:false,focusLosses:0,refreshes:0}}; finish('completed','2026-10-07')");
assert.equal(run('state.answers[0].status'),'timeout');
assert.equal(run('state.answers[0].time_seconds'),180);
assert.equal(run('state.answers[0].answer'),'');
run("state={id:'P01',phase:'main',answers:[],viewport:'1280x900',active:{started:Date.now()-5000,tableUsed:false,focusLosses:0,refreshes:0}}; finish('skipped','')");
assert.equal(run('state.answers[0].status'),'skipped');
assert(run('state.answers[0].time_seconds')>=5);
assert.equal(run('clockPair([])'),'<div class="clock-grid"></div>');
assert.equal(run("data.some(r=>r.date==='2026-11-11')"),false);
assert(!fs.readFileSync('docs/study.js','utf8').includes('const answers'));
console.log('Passed: 159 visits, 10 balanced allocations, distinct variants, timeout, skip, empty date, no client answer key.');
