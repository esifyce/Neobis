import Foundation

// MARK: - magine you are creating a game where the user has to guess the correct number. But there is a limit of how many guesses the user can do. If the user tries to guess more than the limit, the function should throw an error. If the user guess is right it should return true. If the user guess is wrong it should return false and lose a life.

// we use class for implement input correct number and lives
class Guesser {
    // we need realize init, so as we use class
    var number, lives: Int
    // init our class because of no free init
    init(number: Int, lives: Int) {
        self.number = number
        self.lives = lives
    }
    // gameplay our game
    func guess(n: Int) -> Bool {
        // we use for display fatalError if we have spent all our lives and trying again recieved result
        if self.lives < 1 {
            fatalError("Lives is a limit")
        }
        // values equal
        if self.number == n {
            return true
            // values no equal
        } else {
            self.lives -= 1
            return false
        }
    }
}

// Implement guess number and lives after we try play with game
let userGuessNum = Guesser(number: 10, lives: 2)
// return False, because of result no 1 and take a life, then lives = 1
print(userGuessNum.guess(n: 1))
// return True, because of result equal our number
print(userGuessNum.guess(n: 10))
// return True
print(userGuessNum.guess(n: 10))
// return False, because of result no 4 and take a life, then last chance
print(userGuessNum.guess(n: 4))
// again mistake, result is fatalError because of there are no lives left
print(userGuessNum.guess(n: 2))
