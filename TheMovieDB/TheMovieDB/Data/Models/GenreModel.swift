import Foundation

struct GenreModel {
    let id: Int
    let name: String

    init?(entity: GenreEntity) {
        guard let id = entity.id,
            let name = entity.name else { return nil }
        self.id = id
        self.name = name
    }
}
