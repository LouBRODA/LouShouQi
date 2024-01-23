import Foundation
import Model
import ExtensionsTestsCli

//CREATION BOARD TEST

let ratJ1: Piece = Piece(owner: .player1, animal: .rat)
let ratJ2: Piece = Piece(owner: .player2, animal: .rat)
let catJ1: Piece = Piece(owner: .player1, animal: .cat)
let catJ2: Piece = Piece(owner: .player2, animal: .cat)
let dogJ1: Piece = Piece(owner: .player1, animal: .dog)
let dogJ2: Piece = Piece(owner: .player2, animal: .dog)
let wolfJ1: Piece = Piece(owner: .player1, animal: .wolf)
let wolfJ2: Piece = Piece(owner: .player2, animal: .wolf)
let leopardJ1: Piece = Piece(owner: .player1, animal: .leopard)
let leopardJ2: Piece = Piece(owner: .player2, animal: .leopard)
let tigerJ1: Piece = Piece(owner: .player1, animal: .tiger)
let tigerJ2: Piece = Piece(owner: .player2, animal: .tiger)
let lionJ1: Piece = Piece(owner: .player1, animal: .lion)
let lionJ2: Piece = Piece(owner: .player2, animal: .lion)
let elephantJ1: Piece = Piece(owner: .player1, animal: .elephant)
let elephantJ2: Piece = Piece(owner: .player2, animal: .elephant)

let jungleEmptyCell: Cell = Cell(cellType: .jungle)
let waterEmptyCell: Cell = Cell(cellType: .water)
let denEmptyCell: Cell = Cell(cellType: .den)
let trapEmptyCell: Cell = Cell(cellType: .trap)

let ratJ1StartingCell : Cell = Cell(cellType: .jungle, initialOwner: ratJ1.owner, piece: ratJ1)
let ratJ2StartingCell : Cell = Cell(cellType: .jungle, initialOwner: ratJ2.owner, piece: ratJ2)
let catJ1StartingCell : Cell = Cell(cellType: .jungle, initialOwner: catJ1.owner, piece: catJ1)
let catJ2StartingCell : Cell = Cell(cellType: .jungle, initialOwner: catJ1.owner, piece: catJ2)
let dogJ1StartingCell : Cell = Cell(cellType: .jungle, initialOwner: dogJ1.owner, piece: dogJ1)
let dogJ2StartingCell : Cell = Cell(cellType: .jungle, initialOwner: dogJ2.owner, piece: dogJ2)
let wolfJ1StartingCell : Cell = Cell(cellType: .jungle, initialOwner: wolfJ1.owner, piece: wolfJ1)
let wolfJ2StartingCell : Cell = Cell(cellType: .jungle, initialOwner: wolfJ2.owner, piece: wolfJ2)
let leopardJ1StartingCell : Cell = Cell(cellType: .jungle, initialOwner: leopardJ1.owner, piece: leopardJ1)
let leopardJ2StartingCell : Cell = Cell(cellType: .jungle, initialOwner: leopardJ2.owner, piece: leopardJ2)
let tigerJ1StartingCell : Cell = Cell(cellType: .jungle, initialOwner: tigerJ1.owner, piece: tigerJ1)
let tigerJ2StartingCell : Cell = Cell(cellType: .jungle, initialOwner: tigerJ2.owner, piece: tigerJ2)
let lionJ1StartingCell : Cell = Cell(cellType: .jungle, initialOwner: lionJ1.owner, piece: lionJ1)
let lionJ2StartingCell : Cell = Cell(cellType: .jungle, initialOwner: lionJ2.owner, piece: lionJ2)
let elephantJ1StartingCell : Cell = Cell(cellType: .jungle, initialOwner: elephantJ1.owner, piece: elephantJ1)
let elephantJ2StartingCell : Cell = Cell(cellType: .jungle, initialOwner: elephantJ2.owner, piece: elephantJ2)

var startingBoard: Board = Board(withGrid: [
    [lionJ1StartingCell, jungleEmptyCell, trapEmptyCell, denEmptyCell, trapEmptyCell, jungleEmptyCell, tigerJ1StartingCell],
    [jungleEmptyCell, dogJ1StartingCell, jungleEmptyCell, trapEmptyCell, jungleEmptyCell, catJ1StartingCell, jungleEmptyCell],
    [ratJ1StartingCell, jungleEmptyCell, leopardJ1StartingCell, jungleEmptyCell, wolfJ1StartingCell, jungleEmptyCell, elephantJ1StartingCell],
    [jungleEmptyCell, waterEmptyCell, waterEmptyCell, jungleEmptyCell, waterEmptyCell, waterEmptyCell, jungleEmptyCell],
    [jungleEmptyCell, waterEmptyCell, waterEmptyCell, jungleEmptyCell, waterEmptyCell, waterEmptyCell, jungleEmptyCell],
    [jungleEmptyCell, waterEmptyCell, waterEmptyCell, jungleEmptyCell, waterEmptyCell, waterEmptyCell, jungleEmptyCell],
    [jungleEmptyCell, waterEmptyCell, waterEmptyCell, jungleEmptyCell, waterEmptyCell, waterEmptyCell, jungleEmptyCell],
    [elephantJ2StartingCell, jungleEmptyCell, wolfJ2StartingCell, jungleEmptyCell, leopardJ2StartingCell, jungleEmptyCell, ratJ2StartingCell],
    [jungleEmptyCell, catJ2StartingCell, jungleEmptyCell, trapEmptyCell, jungleEmptyCell, dogJ2StartingCell, jungleEmptyCell],
    [tigerJ2StartingCell, jungleEmptyCell, trapEmptyCell, denEmptyCell, trapEmptyCell, jungleEmptyCell, lionJ2StartingCell]
])!



//METHODES BOARD TESTS

var test = startingBoard.description
print(test)

var countPiecesPlayerOne = startingBoard.countOnePlayerPieces(of: .player1)
var countPiecesPlayerTwo = startingBoard.countOnePlayerPieces(of: .player2)
var countPiecesTwoPlayers = startingBoard.countTwoPlayersPieces()

print("Nombre du pièce du joueur 1 :")
print(countPiecesPlayerOne)

print("Nombre du pièce du joueur 2 :")
print(countPiecesPlayerTwo)

print("Nombre de pièces des deux joueurs :")
print(countPiecesTwoPlayers)

print("Board 2 : (suppression de la pièce du Lion du joueur 1)")
let boardState2 = startingBoard.removePiece(atRow: 0, andColumn: 0)
print(startingBoard.description)

print("Nombre du pièce du joueur 1 :")
countPiecesPlayerOne = startingBoard.countOnePlayerPieces(of: .player1)
print(countPiecesPlayerOne)

print("Board 3 : (ajout de la pièce du Lion du joueur 1)")
let boardState3 = startingBoard.insertPiece(piece: lionJ1StartingCell.piece!, atRow: 1, andColumn: 0)
print(startingBoard.description)



//VERY SIMPLE RULES - COMMAND LINE TESTS

//Création et affichage du Board
let rules: VerySimpleRules = VerySimpleRules(occurrences: [:], historic: [])
var initialBoard: Board = VerySimpleRules.createBoard()
print("Create Board - VerySimpleRules")
print(initialBoard.description)

//Vérification de l'état du Board
guard VerySimpleRules.checkBoard(initialBoard) == .noError else {
    print("ERR : VerySimpleRules : Board invalide")
    assert(false, "VerySimpleRules : Board invalide")
}
print("VerySimpleRules : Board valide")

//Affichage du prochain joueur
var player: Owner = rules.getNextPlayer()
print("Prochain joueur :")
print(player)

//Affichage des prochains coups
let nextMovesPlayer1 = rules.getMoves(for: initialBoard, of: .player1)
print("Prochains coups du joueur 1 :")
print(nextMovesPlayer1)

let nextMovesPlayer1Bis = rules.getMoves(for: initialBoard, of: .player1, fromRow: 0, fromColumn: 1)
print("Prochains coups du joueur 1 à partir de la case [0,1] :")
print(nextMovesPlayer1Bis)

//Vérification de l'état de la partie
let gameOver: (Bool, Result) = rules.isGameOver(on: initialBoard, lastMoveRow: 0, lastMoveColumn: 1)
print("Partie terminée ?")
print(gameOver)

//Modification du Board pour le falsifier
let falseBoard = initialBoard.insertPiece(piece: wolfJ1, atRow: 0, andColumn: 0)
print("Le Board est-il valide ?")
if VerySimpleRules.checkBoard(initialBoard) != .noError {
    print("ERR : VerySimpleRules : Board invalide")
} else {
    print("VerySimpleRules : Board valide")
}
