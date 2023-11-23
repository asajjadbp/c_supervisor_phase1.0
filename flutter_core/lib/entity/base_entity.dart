/// Base class that is conformed by all entities
///
/// It allows conversion from entity to model
/// must be used when creating model class to provide a method for converting model to entity
abstract class BaseEntity<T> {
  /// Converts entity to model of type [T]
  T toModel();
}
