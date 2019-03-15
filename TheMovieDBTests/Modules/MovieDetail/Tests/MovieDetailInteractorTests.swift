@testable import TheMovieDB
import XCTest

class MovieDetailInteractorTests: XCTestCase {
    private let movie = MovieModel(id: 0,
                                   title: "",
                                   overview: "",
                                   releaseDate: Date(),
                                   posterPath: "",
                                   voteAverage: 0,
                                   genreIDS: [])

    private var interactorDel: MovieDetailInteractorMockDelegate!

    override func setUp() {
        super.setUp()
        interactorDel = MovieDetailInteractorMockDelegate()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testSaveMovieSuccess() {
        let repository = SavedMoviesMockRepository(status: .success)
        let interactor = MovieDetailInteractor(repository: repository)

        let expect = expectation(description: "Interactor must get movie successfully")
        interactorDel.expect = expect
        interactor.delegate = interactorDel

        interactor.saveMovie(movie)

        wait(for: [expect], timeout: 2.0)

        guard interactorDel.functionsCalled.count == 1 else {
            XCTFail("Unexpected ammount of interactor delegate functions called: \(interactorDel.functionsCalled.count)")
            return
        }
        XCTAssertEqual(interactorDel.functionsCalled[0], "saveMovieSuccess()")
    }

    func testSaveMovieFailure() {
        let repository = SavedMoviesMockRepository(status: .failure)
        let interactor = MovieDetailInteractor(repository: repository)

        let expect = expectation(description: "Interactor must fail on get movie")
        interactorDel.expect = expect
        interactor.delegate = interactorDel

        interactor.saveMovie(movie)

        wait(for: [expect], timeout: 2.0)

        guard interactorDel.functionsCalled.count == 1 else {
            XCTFail("Unexpected ammount of interactor delegate functions called: \(interactorDel.functionsCalled.count)")
            return
        }
        XCTAssertEqual(interactorDel.functionsCalled[0], "saveMovieFailure(error:)")
    }

    func testUnsaveMovieSuccess() {
        let repository = SavedMoviesMockRepository(status: .success)
        let interactor = MovieDetailInteractor(repository: repository)

        let expect = expectation(description: "Interactor must get movie successfully")
        interactorDel.expect = expect
        interactor.delegate = interactorDel

        interactor.unsaveMovie(movie)

        wait(for: [expect], timeout: 2.0)

        guard interactorDel.functionsCalled.count == 1 else {
            XCTFail("Unexpected ammount of interactor delegate functions called: \(interactorDel.functionsCalled.count)")
            return
        }
        XCTAssertEqual(interactorDel.functionsCalled[0], "unsaveMovieSuccess()")
    }

    func testUnsaveMovieFailure() {
        let repository = SavedMoviesMockRepository(status: .failure)
        let interactor = MovieDetailInteractor(repository: repository)

        let expect = expectation(description: "Interactor must fail on get movie")
        interactorDel.expect = expect
        interactor.delegate = interactorDel

        interactor.unsaveMovie(movie)

        wait(for: [expect], timeout: 2.0)

        guard interactorDel.functionsCalled.count == 1 else {
            XCTFail("Unexpected ammount of interactor delegate functions called: \(interactorDel.functionsCalled.count)")
            return
        }
        XCTAssertEqual(interactorDel.functionsCalled[0], "unsaveMovieFailure(error:)")
    }

    func testFetchSavedStatusSaved() {
        let repository = SavedMoviesMockRepository(status: .success)
        let interactor = MovieDetailInteractor(repository: repository)

        let expect = expectation(description: "Interactor must get movie successfully")
        interactorDel.expect = expect
        interactor.delegate = interactorDel

        interactor.fetchSavedStatus(movieId: 0)

        wait(for: [expect], timeout: 2.0)

        guard interactorDel.functionsCalled.count == 1 else {
            XCTFail("Unexpected ammount of interactor delegate functions called: \(interactorDel.functionsCalled.count)")
            return
        }
        XCTAssertEqual(interactorDel.functionsCalled[0], "savedMovieStatusFetched(saved:)")
        XCTAssertTrue(interactorDel.savedStatus)
    }

    func testFetchSavedStatusUnsaved() {
        let repository = SavedMoviesMockRepository(status: .failure)
        let interactor = MovieDetailInteractor(repository: repository)

        let expect = expectation(description: "Interactor must get movie successfully")
        interactorDel.expect = expect
        interactor.delegate = interactorDel

        interactor.fetchSavedStatus(movieId: 0)

        wait(for: [expect], timeout: 2.0)

        guard interactorDel.functionsCalled.count == 1 else {
            XCTFail("Unexpected ammount of interactor delegate functions called: \(interactorDel.functionsCalled.count)")
            return
        }
        XCTAssertEqual(interactorDel.functionsCalled[0], "savedMovieStatusFetched(saved:)")
        XCTAssertFalse(interactorDel.savedStatus)
    }
}
