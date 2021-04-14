//
//  SearchBar.swift
//  DailiaryUI
//
//  Created by Jinwoo Kim on 2021/03/15.
//

import DailiaryReactive

public final class SearchBar: UISearchBar {

    // MARK: - Properties

    private let disposeBag = DisposeBag()
    private let searchKeywordObserver: AnyObserver<String>


    // MARK: - UI

    fileprivate let searchButton = UIButton().then {
        $0.setTitle("검색", for: .normal)
        $0.setTitleColor(ColorPalette.black, for: .normal)
    }


    // MARK: - Initializing

    public init(searchKeywordObserver: AnyObserver<String>) {
        self.searchKeywordObserver = searchKeywordObserver
        super.init(frame: .zero)
        self.initializeLayout()
        self.bind()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func initializeLayout() {
        self.addSubview(self.searchButton)

        super.textField.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(Spacing.s)
            $0.trailing.equalTo(self.searchButton.snp.leading).offset(-Spacing.s)
            $0.centerY.equalToSuperview()
        }
        self.searchButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-Spacing.s)
            $0.centerY.equalToSuperview()
        }
    }

    private func bind() {
        Observable
            .merge(
                self.searchButton.rx.tap.asObservable(),
                self.rx.searchButtonClicked.asObservable()
            )
            .withLatestFrom(self.rx.text)
            .compactMap { $0 }
            .bind(to: self.searchKeywordObserver)
            .disposed(by: self.disposeBag)
    }
}

public extension UISearchBar {
    var textField: UITextField {
        if #available(iOS 13.0, *) {
            return self.searchTextField
        } else {
            guard let searchTextField = self.value(forKey: "_searchField") as? UITextField else {
                return UITextField()
            }
            return searchTextField
        }
    }
}
