import Foundation
import Model
import Persistence
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



//PERSISTENCE - COMMAND LINE TESTS

let jsonEncoder = JSONEncoder()
let jsonDecoder = JSONDecoder()

/*ANIMAL*/
let cat = Animal.cat
let catEncode = try jsonEncoder.encode(cat)
if let catEncodeString = String(data: catEncode, encoding: .utf8){
    print(catEncodeString)
}
let catDecode = try jsonDecoder.decode(Animal.self, from: catEncode)
print(catDecode.rawValue)

/*OWNER*/
let player1 = Owner.player1
let player1Encode = try jsonEncoder.encode(player1)
if let player1EncodeString = String(data: player1Encode, encoding: .utf8){
    print(player1EncodeString)
}
let player1Decode = try jsonDecoder.decode(Owner.self, from: player1Encode)
print(player1Decode.description)

/*CELLTYPE*/
let jungle = CellType.jungle
let jungleEncode = try jsonEncoder.encode(jungle)
if let jungleEncodeString = String(data: jungleEncode, encoding: .utf8){
    print(jungleEncodeString)
}
let jungleDecode = try jsonDecoder.decode(CellType.self, from: jungleEncode)
print(jungleDecode)

/*CELL*/
let ratJ1StartingCellTest : Cell = Cell(cellType: .jungle, initialOwner: ratJ1.owner, piece: ratJ1)
let ratJ1StartingCellTestEncode = try jsonEncoder.encode(ratJ1StartingCellTest)
if let ratJ1StartingCellTestEncodeString = String(data: ratJ1StartingCellTestEncode, encoding: .utf8){
    print(ratJ1StartingCellTestEncodeString)
}
let ratJ1StartingCellTestDecode = try jsonDecoder.decode(Cell.self, from: ratJ1StartingCellTestEncode)
print(ratJ1StartingCellTestDecode)

/*MOVE*/
let moveJ1Test : Move = Move(owner: .player1, rowOrigin: 0, columnOrigin: 0, rowDestination: 0, columnDestination: 1)
let moveJ1TestEncode = try jsonEncoder.encode(moveJ1Test)
if let moveJ1TestEncodeString = String(data: moveJ1TestEncode, encoding: .utf8){
    print(moveJ1TestEncodeString)
}
let moveJ1TestDecode = try jsonDecoder.decode(Move.self, from: moveJ1TestEncode)
print(moveJ1TestDecode)


/*PIECE*/
let ratPieceTest : Piece = Piece(owner: .player1, animal: .rat)
let ratPieceTestEncode = try jsonEncoder.encode(ratPieceTest)
if let ratPieceTestEncodeString = String(data: ratPieceTestEncode, encoding: .utf8){
    print(ratPieceTestEncodeString)
}
let ratPieceTestDecode = try jsonDecoder.decode(Piece.self, from: ratPieceTestEncode)
print(ratPieceTestDecode)

/*BOARD*/
let boardTest : Board = VerySimpleRules.createBoard()
let boardTestEncode = try jsonEncoder.encode(boardTest)
if let boardTestEncodeString = String(data: boardTestEncode, encoding: .utf8){
    print(boardTestEncodeString)
}
let boardTestDecode = try jsonDecoder.decode(Board.self, from: boardTestEncode)
print(boardTestDecode)

/*RULES*/
let verySimpleRulesTest: VerySimpleRules = VerySimpleRules()
let rulesCodable = RulesCodable(occurrences: verySimpleRulesTest.occurrences, historic: verySimpleRulesTest.historic, rulesType: "VerySimpleRules")
let rulesCodableEncode = try jsonEncoder.encode(rulesCodable)
if let rulesCodableEncodeString = String(data: rulesCodableEncode, encoding: .utf8){
    print(rulesCodableEncodeString)
}
let rulesCodableDecode = try jsonDecoder.decode(RulesCodable.self, from: rulesCodableEncode)
let rulesDecode = verySimpleRulesTest.decodeRules(rulesCodable: rulesCodableDecode)
print(rulesDecode)

/*PLAYER*/
let randomPlayerTest: RandomPlayer = RandomPlayer(withName: "RandomPlayer", andId: .player1)!
let playerCodable = PlayerCodable(id: randomPlayerTest.id, name: randomPlayerTest.name, playerType: "RandomPlayer")
let playerCodableEncode = try jsonEncoder.encode(playerCodable)
if let playerCodableEncodeString = String(data: playerCodableEncode, encoding: .utf8){
    print(playerCodableEncodeString)
}
let playerCodableDecode = try jsonDecoder.decode(PlayerCodable.self, from: playerCodableEncode)
let playerDecode = randomPlayerTest.decodePlayer(playerCodable: playerCodableDecode)
print(playerDecode)

let humanPlayerTest: HumanPlayer = HumanPlayer(withName: "HumanPlayer", andId: .player2, andInputMethod: { _ in return Move(owner: .player1, rowOrigin: 0, columnOrigin: 0, rowDestination: 1, columnDestination: 0) })!


/*GAME*/
let gameTest: Game = Game(withRules: verySimpleRulesTest, andPlayer1: randomPlayerTest, andPlayer2: humanPlayerTest)
let gameTestEncode = try jsonEncoder.encode(gameTest)
if let gameTestEncodeString = String(data: gameTestEncode, encoding: .utf8){
    print(gameTestEncodeString)
}
let gameTestDecode = try jsonDecoder.decode(Game.self, from: gameTestEncode)
print(gameTestDecode)

//try await GameFileManager.saveGame(withName: "test", andGame: gameTest)

//VERY SIMPLE RULES - COMMAND LINE TESTS

//Création et affichage du Board
let rules: VerySimpleRules = VerySimpleRules()
var initialBoard: Board = VerySimpleRules.createBoard()
print("Create Board - VerySimpleRules")
print(initialBoard.description)

//Vérification de l'état du Board
guard try VerySimpleRules.checkBoard(initialBoard) == true else {
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
let gameOver: (Bool, Result) = try rules.isGameOver(on: initialBoard, lastMoveRow: 0, lastMoveColumn: 1)
print("Partie terminée ?")
print(gameOver)

////Modification du Board pour le falsifier
let falseBoard = initialBoard.insertPiece(piece: wolfJ1, atRow: 0, andColumn: 0)
print("Le Board est-il valide ?")
do {
    try _ = VerySimpleRules.checkBoard(initialBoard)
    print("VerySimpleRules : Board valide")
} catch InvalidBoardError.numberOfPiece(piecesPlayer1: 6, piecesPlayer2: 5) {
    print("ERR : VerySimpleRules : Board invalide")
}



// PLAYER - COMMAND LINE TOOLS


var playerRules: VerySimpleRules = VerySimpleRules()
var playerBoard: Board = VerySimpleRules.createBoard()
var selectedPiece: Piece
var winningReason: (Bool, Result) = (false, .notFinished)

//Input méthode pour le HumanPlayer
private func inputHumanMethod(humanPlayer: HumanPlayer) -> Move? {
    print("Entrez la ligne de départ de la pièce :")
    guard let rowOriginStr = readLine(), let rowOrigin = Int(rowOriginStr) else {
        print("Ligne de départ invalide.")
        return nil
    }
    
    print("Entrez la colonne de départ de la pièce :")
    guard let columnOriginStr = readLine(), let columnOrigin = Int(columnOriginStr) else {
        print("Colonne de départ invalide.")
        return nil
    }
    
    print("Entrez la ligne de destination de la pièce :")
    guard let rowDestinationStr = readLine(), let rowDestination = Int(rowDestinationStr) else {
        print("Ligne de destination invalide.")
        return nil
    }
    
    print("Entrez la colonne de destination de la pièce :")
    guard let columnDestinationStr = readLine(), let columnDestination = Int(columnDestinationStr) else {
        print("Colonne de destination invalide.")
        return nil
    }
    
    let move = Move(owner: humanPlayer.id, rowOrigin: rowOrigin, columnOrigin: columnOrigin, rowDestination: rowDestination, columnDestination: columnDestination)
    return move
}

/* UNCOMMENT TO TRY A GAME MANUALLY
//Plateau de départ
print(playerBoard)

//Définition des joueurs
let botStupide: RandomPlayer = RandomPlayer(withName: "BotStupide", andId: .player1)!
let humanPlayerLou: HumanPlayer = HumanPlayer(withName: "Lou", andId: .player2, andInputMethod: inputHumanMethod)!

while(winningReason == (false, .notFinished)){
    
    let nextPlayer = playerRules.getNextPlayer()
    var preMovePlayerBoard = playerBoard
    
    if(nextPlayer == botStupide.id){
        //TOUR 1 - RANDOM PLAYER
        print(nextPlayer)

        var _ = rules.getMoves(for: playerBoard, of: botStupide.id)
        let selectMoveRandomPlayer = botStupide.chooseMove(in: playerBoard, with: playerRules)

        selectedPiece = playerBoard.grid[selectMoveRandomPlayer!.rowOrigin][selectMoveRandomPlayer!.columnOrigin].piece!
        _ = playerBoard.removePiece(atRow: selectMoveRandomPlayer!.rowOrigin, andColumn: selectMoveRandomPlayer!.columnOrigin)
        if let _ = playerBoard.grid[selectMoveRandomPlayer!.rowDestination][selectMoveRandomPlayer!.columnDestination].piece {
            _ = playerBoard.removePiece(atRow: selectMoveRandomPlayer!.rowDestination, andColumn: selectMoveRandomPlayer!.columnDestination)
        }
        _ = playerBoard.insertPiece(piece: selectedPiece, atRow: selectMoveRandomPlayer!.rowDestination, andColumn: selectMoveRandomPlayer!.columnDestination)

        print(playerBoard)

        playerRules.playedMove(selectMoveRandomPlayer!, on: preMovePlayerBoard, resultingBoard: playerBoard)

        winningReason = try playerRules.isGameOver(on: playerBoard, lastMoveRow: selectMoveRandomPlayer!.rowDestination, lastMoveColumn: selectMoveRandomPlayer!.columnDestination)
        print(winningReason)
    }
    else if(nextPlayer == humanPlayerLou.id){
        //TOUR 2 - HUMAN PLAYER
        print(nextPlayer)
        
        preMovePlayerBoard = playerBoard
        var _ = rules.getMoves(for: playerBoard, of: humanPlayerLou.id)
        let selectMoveHumanPlayer = humanPlayerLou.chooseMove(in: playerBoard, with: playerRules)
        
        selectedPiece = playerBoard.grid[selectMoveHumanPlayer!.rowOrigin][selectMoveHumanPlayer!.columnOrigin].piece!
        _ = playerBoard.removePiece(atRow: selectMoveHumanPlayer!.rowOrigin, andColumn: selectMoveHumanPlayer!.columnOrigin)
        if let _ = playerBoard.grid[selectMoveHumanPlayer!.rowDestination][selectMoveHumanPlayer!.columnDestination].piece {
            _ = playerBoard.removePiece(atRow: selectMoveHumanPlayer!.rowDestination, andColumn: selectMoveHumanPlayer!.columnDestination)
        }
        _ = playerBoard.insertPiece(piece: selectedPiece, atRow: selectMoveHumanPlayer!.rowDestination, andColumn: selectMoveHumanPlayer!.columnDestination)
        
        print(playerBoard)
        
        playerRules.playedMove(selectMoveHumanPlayer!, on: preMovePlayerBoard, resultingBoard: playerBoard)
        
        winningReason = try playerRules.isGameOver(on: playerBoard, lastMoveRow: selectMoveHumanPlayer!.rowDestination, lastMoveColumn: selectMoveHumanPlayer!.columnDestination)
        print(winningReason)
    }
}
*/


// GAME - COMMAND LINE TOOLS

/* UNCOMMENT TO WATCH A RANDOM PLAYER GAME
var verySimpleRules: VerySimpleRules = VerySimpleRules()
let randomPlayer: RandomPlayer = RandomPlayer(withName: "RandomPlayer", andId: .player1)!
let randomPlayer2: RandomPlayer = RandomPlayer(withName: "RandomPlayer2", andId: .player2)!

var game = Game(withRules: verySimpleRules, andPlayer1: iAPlayer, andPlayer2: randomPlayer2)
let consoleGameNotificationObserver = ConsoleGameNotificationObserver()
game.addObserver(consoleGameNotificationObserver)
try game.start()
*/
 
/* UNCOMMENT TO PLAY AGAINST A RANDOM PLAYER
var verySimpleRules: VerySimpleRules = VerySimpleRules()
let randomPlayer: RandomPlayer = RandomPlayer(withName: "RandomPlayer", andId: .player1)!
let humanPlayer: HumanPlayer = HumanPlayer(withName: "Lou", andId: .player2, andInputMethod: inputHumanMethod)!

var game = Game(withRules: verySimpleRules, andPlayer1: randomPlayer, andPlayer2: humanPlayer)
let consoleGameNotificationObserver = ConsoleGameNotificationObserver()
game.addObserver(consoleGameNotificationObserver)
try game.start()
*/

/* UNCOMMENT TO WATCH A RANDOM PLAYER VS IAPLAYER GAME
var verySimpleRules: VerySimpleRules = VerySimpleRules()
let iAPlayer: IAPlayer = IAPlayer(withName: "IAPlayer", andId: .player1)!
let randomPlayer2: RandomPlayer = RandomPlayer(withName: "RandomPlayer", andId: .player2)!

var game = Game(withRules: verySimpleRules, andPlayer1: iAPlayer, andPlayer2: randomPlayer2)
let consoleGameNotificationObserver = ConsoleGameNotificationObserver()
game.addObserver(consoleGameNotificationObserver)
try game.start()
*/
 
var verySimpleRules: VerySimpleRules = VerySimpleRules()
let iAPlayer: IAPlayer = IAPlayer(withName: "IAPlayer", andId: .player1)!
let humanPlayer: HumanPlayer = HumanPlayer(withName: "Lou", andId: .player2, andInputMethod: inputHumanMethod)!

print("Voulez-vous continuer la dernière partie ? (O/N)")
if let response = readLine()?.uppercased() {
    if (response == "O") {
        var game = try await GameFileManager.loadGame(withName: "game");
        print(game?.board)
        try game?.start()
    }
    else {
        var game = Game(withRules: verySimpleRules, andPlayer1: iAPlayer, andPlayer2: humanPlayer)
        let consoleGameNotificationObserver = ConsoleGameNotificationObserver()
        game.addObserver(consoleGameNotificationObserver, gameSavedHandler: saveMethod)
        try game.start()
    }
}

func saveMethod(game: Game) {
    do {
        try GameFileManager.saveGame(withName: "game", andGame: game);
    }
    catch {
        print("Échec de la sauvegarde de Game : \(error)")
    }
}
