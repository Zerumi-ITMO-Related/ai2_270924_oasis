import it.unibo.tuprolog.core.Term
import it.unibo.tuprolog.core.parsing.parse
import it.unibo.tuprolog.solve.Solution
import it.unibo.tuprolog.solve.Solver.Companion.prolog
import it.unibo.tuprolog.theory.Theory
import it.unibo.tuprolog.theory.parsing.parse
import java.util.*

fun locationArgumentProvider(input: String) = input.substringAfter("Where is").substringBefore("?").trim()
fun hasAllKeysArgumentProvider(input: String) = input.substringAfter("Is").substringBefore("has all keys?").trim()
fun locationRequestProvider(arg: String) = "location($arg, X)."
fun hasAllKeysRequestProvider(arg: String) = "has_all_keys($arg)."

fun parseUserInput(input: String) : String {
    val dictionary = mapOf(
        Pair("Where is", "?") to Pair(::locationArgumentProvider, ::locationRequestProvider),
        Pair("Is", "has all keys?") to Pair(::hasAllKeysArgumentProvider, ::hasAllKeysRequestProvider),
    )
    for (entry in dictionary) {
        if (input.startsWith(entry.key.first) && input.endsWith(entry.key.second)) {
            val arg = entry.value.first(input)
            return entry.value.second(arg)
        }
    }
    return input
}

fun readKnowledgeBase(fileName: String) : String {
    val classloader = Thread.currentThread().contextClassLoader
    val file = classloader.getResourceAsStream(fileName)
    val scanner = Scanner(file).useDelimiter("\\A")
    return if (scanner.hasNext()) scanner.next() else ""
}

fun main(args: Array<String>) {
    // input & parse
    val userInput = parseUserInput(readln())

    // load knowledge base
    val knowledgeBase = readKnowledgeBase("oasis.pl")
    val theory = Theory.parse(knowledgeBase)

    // use prolog term to ask something from knowledge base
    val solver = prolog.solverOf(staticKb = theory)

    // parse the user input into a Prolog term
    val query = Term.parse(userInput)

    // execute the query and get the solutions
    val solutions = solver.solve(query.castToStruct()).toList()

    // solution
    if (solutions.isEmpty()) {
        println("No solutions found for query: $userInput")
    } else {
        println("Solutions for query: $userInput")
        for (solution in solutions) {
            when (solution) {
                is Solution.Yes -> println("Solution: ${solution.substitution}")
                is Solution.No -> println("No solution found.")
                is Solution.Halt -> println("Query halted with reason: ${solution.exception}")
            }
        }
    }
}