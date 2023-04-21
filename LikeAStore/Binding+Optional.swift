import SwiftUI

public func ?? <T>(lhs: Binding<Optional<T>>, rhs: T) -> Binding<T> {
    Binding(
        get: { lhs.wrappedValue ?? rhs },
        set: { lhs.wrappedValue = $0 }
    )
}

// MARK: - TextField

extension TextField where Label == Text {
    public init(_ title: String, text: Binding<String?>) {
        self.init(title, text: text ?? "")
    }

    public init(_ title: String, number: Binding<Int?>) {
        let mappedBinding = Binding<String?>(get: {
            number.wrappedValue.map { "\($0)" }
        }, set: { value, transaction in
            if let value = value {
                number.wrappedValue = Int(value)
            } else {
                number.wrappedValue = nil
            }
        })

        self.init(title, text: mappedBinding)
    }
}
