/// Base class that is conformed by all model
///
/// It allows conversion from model to entity
/// Must be used when creating model class to provide a method for converting model to entity
abstract class BaseModel<T> {
  /// Converts model to entity of type [T]
  T toEntity();
}
