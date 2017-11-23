import PetriKit
import PhilosophersLib

do {
    let philosophers = lockFreePhilosophers(n: 5)
    let philosophersMarking = philosophers.markingGraph(from : philosophers.initialMarking!)
    print("For the unlockable Philosophers model with 5 philosophers, there are \(philosophersMarking!.count) possible markings.\n")
}

do {
  let philosophers = lockablePhilosophers(n: 5)
  let philosophersMarking = philosophers.markingGraph(from : philosophers.initialMarking!)
  print("For the lockable Philosophers model with 5 philosophers, there are \(philosophersMarking!.count) possible markings.\n")

  lock : for node in philosophersMarking! {
    var isFound = true
    for (_, e) in node.successors {
      if e.count != 0 {
        isFound = false
      }
    }
    if isFound {
      print("There's a locked case with the marking \(node.marking).")
      break lock
    }
  }
}


/*
--Exercice fait en classe le 17 octobre--
do {
  // dom(Ingredients) = {p, t, m}
  enum Ingredients {
    case p, t, m
  }
  // dom(Smokers) = {mia, bob, tom}
  enum Smokers {
    case mia, bob, tom
  }
  // dom(Referee) = {rob}
  enum Referee {
    case Rob
  }
  // Tapes = {Ingredients, Smokers, Referee}
  enum Types {
    case ingredients(Ingredients)
    case smokers(Smokers)
    case referee(Referee)
  }

  let s = PredicateTransition<Types>(
    preconditions : [
      PredicateArc(place: "i", label: [.variable("x"), .variable("y")]),
      PredicateArc(place: "s", label: [.variable("s")]),
    ],
    preconditions : [
      PredicateArc(place: "r", label: [.function({_ in .referee(.bob)})]),
      PredicateArc(place: "w", label: [.variable("s")]),
    ],
    conditions : [{ binding init() {
        // Retrieve the indices of the philosopher and forks from the binding.
        guard case let .smokers(s) = binding["s"]!,
              case let .ingredients(x) = binding["x"]!,
              case let .ingredients(y) = binding["y"]!
        else {
          return false
        }
        switch (s, x, y) {
        case (.mia, .p, .t): return true
        case (.tom, .p, .m): return true
        case (.bob, .t, .m): return true
        default : return false
        }
    }}]
  )
}
*/
