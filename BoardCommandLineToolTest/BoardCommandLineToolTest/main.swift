import Foundation
import Model
import ExtensionsTestsCli

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

let startingBoard: Board = Board(grid: [
    [lionJ1StartingCell, jungleEmptyCell, trapEmptyCell, denEmptyCell, trapEmptyCell, jungleEmptyCell, lionJ1StartingCell],
    [jungleEmptyCell, dogJ1StartingCell, jungleEmptyCell, trapEmptyCell, jungleEmptyCell, catJ1StartingCell, jungleEmptyCell],
    [ratJ1StartingCell, jungleEmptyCell, leopardJ1StartingCell, jungleEmptyCell, wolfJ1StartingCell, jungleEmptyCell, elephantJ1StartingCell],
    [jungleEmptyCell, waterEmptyCell, waterEmptyCell, jungleEmptyCell, waterEmptyCell, waterEmptyCell, jungleEmptyCell],
    [jungleEmptyCell, waterEmptyCell, waterEmptyCell, jungleEmptyCell, waterEmptyCell, waterEmptyCell, jungleEmptyCell],
    [jungleEmptyCell, waterEmptyCell, waterEmptyCell, jungleEmptyCell, waterEmptyCell, waterEmptyCell, jungleEmptyCell],
    [jungleEmptyCell, waterEmptyCell, waterEmptyCell, jungleEmptyCell, waterEmptyCell, waterEmptyCell, jungleEmptyCell],
    [elephantJ2StartingCell, jungleEmptyCell, wolfJ2StartingCell, jungleEmptyCell, leopardJ2StartingCell, jungleEmptyCell, ratJ2StartingCell],
    [jungleEmptyCell, catJ2StartingCell, jungleEmptyCell, trapEmptyCell, jungleEmptyCell, dogJ2StartingCell, jungleEmptyCell],
    [lionJ2StartingCell, jungleEmptyCell, trapEmptyCell, denEmptyCell, trapEmptyCell, jungleEmptyCell, lionJ2StartingCell]
])!

var test = startingBoard.description
print(test)
