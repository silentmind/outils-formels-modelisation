//Ex 04.2
typealias PTMarking = String

class MarkingGraph CustomStringConvertible {
  let marking : PTMarking
  var successors : [PPTransition: MarkingGraph] //"let" was a mistake from the teacher  <3

  init (marking : PTMarking, successors : [MarkingGraph]) { //initialise, demande 2 paramètres
    self.marking   = marking
    self.successors = successors
  }

  var description: String {
    return String(describing: self.marking)
  }
}

var m0 = MarkingGraph(marking: ["p1","p2","p3","f1","f2","f3"], successors: []) //dans petrikit, il faudra donner les places réelles et nb de jetons
var m1 = MarkingGraph(marking: ["p1","p2","q3","f2"], successors: [m0])
var m2 = MarkingGraph(marking: ["p1","q2","p3","f1"], successors: [m0])
var m3 = MarkingGraph(marking: ["q1","p2","p3","f3"], successors: [m0])

m0.successors = [m1, m2, m3] // Dans le tp02, il faudra indiquer [t3:m1, t2:m2, ...] -> t3 pour m1, t2 pour m2

// 2 façons de louer l'espace, stack ou tas (heap?hip?), ...
