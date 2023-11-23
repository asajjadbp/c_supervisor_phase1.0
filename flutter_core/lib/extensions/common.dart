/// Safe cast value to the type of [T], Returns null if unable to cast
T? safeCast<T>(x) => x is T ? x : null;
