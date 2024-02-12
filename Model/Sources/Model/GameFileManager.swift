import Foundation

public struct GameFileManager {
    
    public static func getSaveDirectoryUrl() throws -> URL {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            fatalError("Impossible de récupérer le répertoire des documents de l'utilisateur !")
        }
        let baseUrl = documentsDirectory.appendingPathComponent("Games")
        // Vérifier si le répertoire existe et le créer s'il n'existe pas
        if !FileManager.default.fileExists(atPath: baseUrl.path) {
            try FileManager.default.createDirectory(at: baseUrl, withIntermediateDirectories: true, attributes: nil)
        }
        return baseUrl
    }
    
    public static func loadGame(withName name: String) async throws -> Game? {
        let task = Task<Game?, Error> {
            let fileUrl = try self.getSaveDirectoryUrl().appending(path: name)
            guard let data = try? Data(contentsOf: fileUrl) else {
                return nil
            }
            let game = try JSONDecoder().decode(Game.self, from: data)
            return game
        }
        return try await task.value
        
    }
    
    public static func saveGame(withName name: String, andGame game: Game) async throws {
        let task = Task {
            do {
                let data = try JSONEncoder().encode(game)
                let outfile = try Self.fileURL.appending(path: name)
                try data.write(to: outfile)
            }
            catch {
            }
        }
        _ = try await task.value
    }
}
