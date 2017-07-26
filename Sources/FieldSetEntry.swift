import Node

/// Value representing an entry for a Field Set
public struct FieldSetEntry {
    public let key: String
    public let label: String?
    public let value: NodeRepresentable?
    public let errors: [String]

    public init(
        key: String,
        label: String? = nil,
        value: NodeRepresentable? = nil,
        errors: [String] = []
    ) {
        self.key = key
        self.label = label
        self.value = value
        self.errors = errors
    }
}

extension FieldSetEntry {

    /// Returns false when the field
    public var isValid: Bool {
        return errors.count == 0
    }
}

// MARK: NodeRepresentable

extension FieldSetEntry: NodeRepresentable {
    public func makeNode(in context: Context?) throws -> Node {
        var node = Node([:])

        if let label = label {
            node["label"] = .string(label)
        }

        if let value = value {
            node["value"] = try value.makeNode(in: nil)
        }

        if !isValid {
            node["errors"] = .array(errors.map { Node.string($0) })
        }

        return node
    }
}
