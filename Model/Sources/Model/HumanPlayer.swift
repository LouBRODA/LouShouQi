import Foundation

public class HumanPlayer : Player {
    
    public let input: () -> Move
    
    /// Initialiseur du HumanPlayer.
    ///
    /// - Parameters:
    ///   - name: Nom du joueur.
    ///   - id: Identifiant du joueur.
    ///   - input: La méthode permettant de récupérer
    public init?(withName name: String, andId id: Owner, andInputMethod input: @escaping () -> Move) {
        self.input = input
        super.init(withName: name, andId: id)
    }
    
    /// Permet de rendre un coup pour un plateau particulier et des règles particulières.
    ///
    /// - Parameters:
    ///   - board: Le plateau de jeu actuel.
    ///   - rules: Les règles choisies pour la partie en cours.
    /// - Returns: Le coup choisi.
    public override func chooseMove(in board: Board, with rules: any Rules) -> Move? {
        return input()
    }
}
