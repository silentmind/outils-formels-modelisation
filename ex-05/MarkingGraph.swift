public class MarkingGraph {

    public typealias Marking = [String: Int]

    public let marking   : Marking
    public var successors: [String: MarkingGraph]

    public init(marking: Marking, successors: [String: MarkingGraph] = [:]) {
        self.marking    = marking
        self.successors = successors
    }
}

// VERSION AVEC ITÉRATION
func countNodes(MarkingGraph: MarkingGraph) -> Int {

  var seen = [markingGraph]
  var toVisit = [markingGraph]

  while let current = toVisit.popLast() {
    for (_, successor) in current.successors {
      if !seen.contains(where: {$0 === successor}) {
        seen.append(successor)
        toVisit.append(successor)
        // ici, tout les noeuds sont vus, possibilité d'écrire du code pour checker qqch sur l'arcade
        // TP: check s'il y a plus... EX :
        if marking.first(where: { $0.1 > 1 }) != nil{
          return true
        }
      }
    }
  }
  return seen.count // Compter le nombre de noeuds vus, no PRINT pour le TP, RETURN!!!
}

// OR - VERSION RÉCURSIVE
func countNodes(MarkingGraph: MarkingGraph, seen: inout [markingGraph]) -> Int {

  seen.append(successor)

  for (_, successor) in current.successors {
    if !seen.contains(where: {$0 === successor}) {
        seen.append(successor)
        _ = countNodes(markingGraph: successor, seen: &seen)
    }
  }
  return seen.count
}

// Ex. 1: Mutual exclusion
  // Q1. 3 états attaignables depuis l'état initial.
  // Q2. Vivant
  // Q3. Encodez:
do {
    let m0 = MarkingGraph(marking: ["s0": 1, "s1": 0, "s2": 1, "s3": 0, "s4": 1])
    let m1 = MarkingGraph(marking: ["s0": 0, "s1": 1, "s2": 0, "s3": 0, "s4": 1)
    let m2 = MarkingGraph(marking: ["s0": 1, "s1": 0, "s2": 0, "s3": 1, "s4": 0)

    m0.successors = ["t1": m1, "t3": m2]
    m1.successors = ["t0": m0]
    m2.successors = ["t2": m0]
}

// Ex. 2: PetriNet 1
do {  // On créer les marquages/états (??)
    let m0 = MarkingGraph(marking: ["p0": 2, "p1": 0]) // 2 places
    let m1 = MarkingGraph(marking: ["p0": 1, "p1": 1])
    let m2 = MarkingGraph(marking: ["p0": 0, "p1": 2])

    // on créer les arcs-transitions
    m0.successors = ["t0": m1]  // 2 transitions
    m1.successors = ["t0": m2, "t1": m0]
    m2.successors = ["t1": m1]

    // Write your code here ...
    let p0 = PTPlace(named: "p0")
    let p1 = PTPlace(named: "p1")

    let t0 = PTTransition(
        named         : "t0",
        preconditions : [PTArc(place: p1)],
        postconditions: [PTArc(plsace: p0)])
    let t1 = PTTransition(
        named         : "t1",
        preconditions : [PTArc(place: p0)],
        postconditions: [PTArc(place: p1), PTArc(place: p2)])
}

// Ex. 2: PetriNet 2
do {
    let m0 = MarkingGraph(marking: ["p0": 1, "p1": 0, "p2": 0, "p3": 0, "p4": 0])
    let m1 = MarkingGraph(marking: ["p0": 0, "p1": 1, "p2": 0, "p3": 1, "p4": 0])
    let m2 = MarkingGraph(marking: ["p0": 0, "p1": 0, "p2": 1, "p3": 1, "p4": 0])
    let m3 = MarkingGraph(marking: ["p0": 0, "p1": 1, "p2": 0, "p3": 0, "p4": 1])
    let m4 = MarkingGraph(marking: ["p0": 0, "p1": 0, "p2": 0, "p3": 1, "p4": 0])
    let m5 = MarkingGraph(marking: ["p0": 0, "p1": 0, "p2": 1, "p3": 0, "p4": 1])
    let m6 = MarkingGraph(marking: ["p0": 0, "p1": 1, "p2": 0, "p3": 0, "p4": 0])
    let m7 = MarkingGraph(marking: ["p0": 0, "p1": 0, "p2": 0, "p3": 0, "p4": 1])
    let m8 = MarkingGraph(marking: ["p0": 0, "p1": 0, "p2": 1, "p3": 0, "p4": 0])
    let m9 = MarkingGraph(marking: ["p0": 0, "p1": 0, "p2": 0, "p3": 0, "p4": 0])

    m0.successors = ["t0": m1]
    m1.successors = ["t1": m2, "t3": m3]
    m2.successors = ["t2": m4, "t3": m5]
    m3.successors = ["t1": m5, "t4": m6]
    m4.successors = ["t3": m7]
    m5.successors = ["t2": m7, "t4": m8]
    m6.successors = ["t1": m8]
    m7.successors = ["t4": m9]
    m8.successors = ["t2": m9]

    // Write your code here ...
}

// Ex. 2: PetriNet 3
do {
    let m0 = MarkingGraph(marking: ["p0": 0, "p1": 2])
    let m1 = MarkingGraph(marking: ["p0": 1, "p1": 1])
    let m2 = MarkingGraph(marking: ["p0": 2, "p1": 0])

    m0.successors = ["t1": m1]
    m1.successors = ["t0": m1, "t1": m2]
    m2.successors = ["t2": m0]

    // Write your code here ...
}
