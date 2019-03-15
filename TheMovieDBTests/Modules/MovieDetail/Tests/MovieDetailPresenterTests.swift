@testable import TheMovieDB
import XCTest

class MovieDetailPresenterTests: XCTestCase {
    private let movie = MovieModel(id: 0,
                                   title: "",
                                   overview: "",
                                   releaseDate: Date(),
                                   posterPath: "",
                                   voteAverage: 0,
                                   genreIDS: [])

    private var interactor: MovieDetailMockInteractor!
    private var router: MovieDetailMockRouter!
    private var view: MovieDetailMockView!
    private var presenter: MovieDetailPresenterProtocol!

    override func setUp() {
        super.setUp()
        interactor = MovieDetailMockInteractor()
        router = MovieDetailMockRouter()
        view = MovieDetailMockView()
        presenter = MovieDetailPresenter(interactor: interactor, router: router)
        presenter.view = view
    }

    override func tearDown() {
        super.tearDown()
    }

    func testViewDidLoad() {
        presenter.viewDidLoad(movie: movie)

        guard view.functionsCalled.count == 1 else {
            XCTFail("Unexpected ammount of view functions called: \(view.functionsCalled.count)")
            return
        }

        XCTAssertEqual(view.functionsCalled[0], "showLoading()")

        guard interactor.functionsCalled.count == 1 else {
            XCTFail("Unexpected ammount of interactor functions called: \(interactor.functionsCalled.count)")
            return
        }

        XCTAssertEqual(interactor.functionsCalled[0], "fetchSavedStatus(movieId:)")
        XCTAssertEqual(router.functionsCalled.count, 0)
    }

    func testViewDidLoadNilMovie() {
        presenter.viewDidLoad(movie: nil)
        XCTAssertEqual(view.functionsCalled.count, 0)
        XCTAssertEqual(interactor.functionsCalled.count, 0)
        XCTAssertEqual(router.functionsCalled.count, 0)
    }

    func testDidTapSaveButtonSave() {
        let isDelete = false

        presenter.didTapSaveButton(movie: movie, isDelete: isDelete)

        guard view.functionsCalled.count == 1 else {
            XCTFail("Unexpected ammount of view functions called: \(view.functionsCalled.count)")
            return
        }

        XCTAssertEqual(view.functionsCalled[0], "showLoading()")

        guard interactor.functionsCalled.count == 1 else {
            XCTFail("Unexpected ammount of interactor functions called: \(interactor.functionsCalled.count)")
            return
        }

        XCTAssertEqual(interactor.functionsCalled[0], "saveMovie")
        XCTAssertEqual(router.functionsCalled.count, 0)
    }

    func testDidTapSaveButtonUnsave() {
        let isDelete = true
        presenter.view = view

        presenter.didTapSaveButton(movie: movie, isDelete: isDelete)

        guard view.functionsCalled.count == 1 else {
            XCTFail("Unexpected ammount of view functions called: \(view.functionsCalled.count)")
            return
        }

        XCTAssertEqual(view.functionsCalled[0], "showLoading()")

        guard interactor.functionsCalled.count == 1 else {
            XCTFail("Unexpected ammount of interactor functions called: \(interactor.functionsCalled.count)")
            return
        }

        XCTAssertEqual(interactor.functionsCalled[0], "unsaveMovie")
        XCTAssertEqual(router.functionsCalled.count, 0)
    }

    func testDidTapCloseButton() {
        presenter.view = view

        presenter.didTapCloseButton()

        XCTAssertEqual(interactor.functionsCalled.count, 0)
        XCTAssertEqual(view.functionsCalled.count, 0)
        guard router.functionsCalled.count == 1 else {
            XCTFail("Unexpected ammount of router functions called: \(router.functionsCalled.count)")
            return
        }

        XCTAssertEqual(router.functionsCalled[0], "dismiss()")
    }
}
