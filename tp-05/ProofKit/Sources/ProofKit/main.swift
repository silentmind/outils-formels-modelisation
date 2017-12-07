import ProofKitLib

let a: Formula = "a"
let b: Formula = "b"
let c: Formula = "c"

let f = a && b
print(f)
print("Forme NNF: \(f.nnf)")
print("Forme DNF: \(f.nnf.dnf)")
print("Forme CNF: \(f.nnf.cnf)")
print("\n")

let g = !(a && b)
print(g)
print("Forme NNF: \(g.nnf)")
print("Forme DNF: \(g.nnf.dnf)")
print("Forme CN: \(g.nnf.cnf)")
print("\n")

let h = ( a => b) && !b
print(h)
print("Forme NNF: \(h.nnf)")
print("Forme DNF: \(h.nnf.dnf)")
print("Forme CNF: \(h.nnf.cnf)")
print("\n")

let i = (a => b) || !(a && c)
print(i)
print("Forme NNF: \(i.nnf)")
print("Forme DNF: \(i.nnf.dnf)")
print("Forme CNF: \(i.nnf.cnf)")
print("\n")


let booleanEvaluation = f.eval { (proposition) -> Bool in
    switch proposition {
        case "p": return true
        case "q": return false
        default : return false
    }
}
print(booleanEvaluation)

enum Fruit: BooleanAlgebra {

    case apple, orange

    static prefix func !(operand: Fruit) -> Fruit {
        switch operand {
        case .apple : return .orange
        case .orange: return .apple
        }
    }

    static func ||(lhs: Fruit, rhs: @autoclosure () throws -> Fruit) rethrows -> Fruit {
        switch (lhs, try rhs()) {
        case (.orange, .orange): return .orange
        case (_ , _)           : return .apple
        }
    }

    static func &&(lhs: Fruit, rhs: @autoclosure () throws -> Fruit) rethrows -> Fruit {
        switch (lhs, try rhs()) {
        case (.apple , .apple): return .apple
        case (_, _)           : return .orange
        }
    }

}

let fruityEvaluation = f.eval { (proposition) -> Fruit in
    switch proposition {
        case "p": return .apple
        case "q": return .orange
        default : return .orange
    }
}
print(fruityEvaluation)
