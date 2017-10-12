import TaskManagerLib

// Ex. 03
print("TP 1, Ex 03: Analyse du problème")

let taskManager = createTaskManager()

let create = taskManager.transitions.filter{$0.name == "create"}[0]
let spawn = taskManager.transitions.filter{$0.name == "spawn"}[0]
let exec = taskManager.transitions.filter{$0.name == "exec"}[0]
let success = taskManager.transitions.filter{$0.name == "success"}[0]
let fail = taskManager.transitions.filter{$0.name == "fail"}[0]

let taskPool = taskManager.places.filter{$0.name == "taskPool"}[0]
let processPool = taskManager.places.filter{$0.name == "processPool"}[0]
let inProgress = taskManager.places.filter{$0.name == "inProgress"}[0]

// Executions that lead to the problem
let m1 = create.fire(from: [taskPool: 0, processPool: 0, inProgress: 0])
print("m1 - Create ", m1!)
let m2 = spawn.fire(from: m1!)
print("m2 - Spawn ", m2!)
let m3 = spawn.fire(from: m2!)
print("m3 - Spawn ", m3!)
let m4 = exec.fire(from: m3!)
print("m4 - Exec ", m4!)
let m5 = exec.fire(from: m4!)
print("m5 - Exec ", m5!)
let m6 = success.fire(from: m5!)
print("m6 - Success ", m6!) // Success.
// inProgress still has a token but it's ok, it will fail as the task is deleted

//Ex. 04
print("TP 1, Ex 04: Correction du problème")
let correctTaskManager = createCorrectTaskManager()

let recreate = correctTaskManager.transitions.filter{$0.name == "create"}[0]
let respawn = correctTaskManager.transitions.filter{$0.name == "spawn"}[0]
let reexec = correctTaskManager.transitions.filter{$0.name == "exec"}[0]
let resuccess = correctTaskManager.transitions.filter{$0.name == "success"}[0]
let refail = correctTaskManager.transitions.filter{$0.name == "fail"}[0]

let retaskPool = correctTaskManager.places.filter{$0.name == "taskPool"}[0]
let reprocessPool = correctTaskManager.places.filter{$0.name == "processPool"}[0]
let reinProgress = correctTaskManager.places.filter{$0.name == "inProgress"}[0]
let checkTask = correctTaskManager.places.filter{$0.name == "checkTask"}[0]

// Solution
let t1 = recreate.fire(from: [retaskPool: 0, reprocessPool: 0, reinProgress: 0, checkTask: 0])
print("t1 - Create ",t1!)
let t2 = respawn.fire(from: t1!)
print("t2 - Spawn ",t2!)
let t3 = respawn.fire(from: t2!)
print("t3 - Spawn ",t3!)
let t4 = reexec.fire(from: t3!)
print("t4 - Exec ",t4!)
let t5 = resuccess.fire(from: t4!)
print("t5 - SUCCESS ",t5!) // Success.
let t6 = refail.fire(from: t4!)
print("t5 - FAIL ",t6!) // Fail.
