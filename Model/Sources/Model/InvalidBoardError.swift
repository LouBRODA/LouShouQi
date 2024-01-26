import Foundation

/// Énumération définissant les erreurs possibles liées à un plateau de jeu invalide.
public enum InvalidBoardError: Error, Hashable {
    /// Erreur de dimensions du plateau.
    case badDimensions(row: Int, column: Int)
    
    /// Erreur de type de cellule invalide sur le plateau.
    case badCellType(cellType: CellType, row: Int, column: Int)
    
    /// Erreur de présence multiple de la même pièce sur le plateau.
    case multipleOccurrencesOfSamePiece(piece: Piece)
    
    /// Erreur de pièce sans propriétaire sur le plateau.
    case pieceWithNoOwner(piece: Piece)
    
    /// Erreur de pièce non autorisée sur une cellule spécifique.
    case pieceNotAllowedOnThisCell(piece: Piece, onCell: Cell)
    
    /// Erreur du nombre incorrect de pièces pour chaque joueur sur le plateau.
    case numberOfPiece(piecesPlayer1: Int, piecesPlayer2: Int)
    
    /// Erreur d'autorisation d'animal sur le plateau.
    case animalNotAuthorized
    
    /// Aucune erreur détectée.
    case noError
}
