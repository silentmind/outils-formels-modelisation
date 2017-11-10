import PetriKit

public extension PTNet {

    public func coverabilityGraph(from marking: CoverabilityMarking) -> CoverabilityGraph {
        // Write here the implementation of the coverability graph generation.

        // Note that CoverabilityMarking implements both `==` and `>` operators, meaning that you
        // may write `M > N` (with M and N instances of CoverabilityMarking) to check whether `M`
        // is a greater marking than `N`.

        // IMPORTANT: Your function MUST return a valid instance of CoverabilityGraph! The optional
        // print debug information you'll write in that function will NOT be taken into account to
        // evaluate your homework.
        let transitions = self.transitions
        let firstNode = CoverabilityGraph(marking: marking)
        var toVisit = [CoverabilityGraph]()
        var visitedGraphs = [CoverabilityGraph]()

        // Initial node is the first visited node
        toVisit.append(firstNode)

        while(!toVisit.isEmpty) {
          let currentGraph = toVisit.remove(at:0)
          visitedGraphs.append(currentGraph)

          // fire each fireable transition and process the new generated markings
          for t in transitions {
            if var newMark = t.fire(from: currentGraph.marking) {
              newMark = omegaAdd(newMark, visitedGraphs)
              if let alreadyVisitedGraph = visitedGraphs.first(where: {$0.marking == newMark}) {
                currentGraph.successors[t] = alreadyVisitedGraph
              }
              else {
                let discoveredGraph = CoverabilityGraph(marking: newMark)
                currentGraph.successors[t] = discoveredGraph

                if (!toVisit.contains(where: {discoveredGraph.marking > $0.marking})) {
                  if (!toVisit.contains(where: {$0.marking == discoveredGraph.marking})) {
                    toVisit.append(discoveredGraph)
                  }
                }
              }
            }
          }
        }
        return firstNode
      }
    }

    public extension PTTransition {
      public func isFireable(from marking: CoverabilityMarking) -> Bool {
        for a in self.preconditions {
          if case .some(let n) = marking[a.place]! {
            if n < a.tokens {
              return false
            }
          }
        }
        return true
      }

      public func fire(from marking: CoverabilityMarking) -> CoverabilityMarking? {
        guard self.isFireable(from: marking) else {
          return nil
        }
        var result = marking

        for a in self.preconditions {
          if case .some(let n) = result[a.place]! {
            result[a.place]! = .some(n - a.tokens)
          }
        }
        for a in self.postconditions {
          if case .some(let n) = result[a.place]! {
            result[a.place]! = .some(n + a.tokens)
          }
        }
        return result
      }
    }

    fileprivate func omegaAdd(_ marking: CoverabilityMarking, _ graphs: [CoverabilityGraph]) -> CoverabilityMarking {
      var ret = marking
      for pastNode in graphs {
        if ret > pastNode.marking{
          for place in ret.keys {
            if ret[place]! > pastNode.marking[place]! {
              ret[place] = .omega
            }
          }
          return ret
        }
      }
      return marking
    }
