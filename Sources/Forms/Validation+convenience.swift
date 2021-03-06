import Validation

extension Validator {
    public func transformingErrors(
        to error: Error
    ) -> ValidatorWrapper<Input> {
        return ValidatorWrapper(validator: self, error: error)
    }

    public func allowingNil(
        _ isOptional: Bool = true,
        errorOnNil: FormFieldValidationError = OptionalValidatorError.nilValue
    ) -> OptionalValidator<Input> {
        return OptionalValidator(isOptional: isOptional, errorOnNil: errorOnNil, validator: self)
    }
}
