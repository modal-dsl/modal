package de.joneug.mdal.extensions

import org.apache.log4j.Logger

/**
 * This is an extension library for all {@link Object objects}.
 */
class ObjectExtensions {
	
	static def replaceEmptyField(Object object, String fieldName, Object defaultValue) {
		val field = object.getClass().getDeclaredField(fieldName)
		field.setAccessible(true)
		
		if (field.get(object) === null) {
			object.logInfo('''Field "«fieldName»" is not set - defaulting to "«defaultValue.toString»"''')
			field.set(object, defaultValue)			
		}
	}
	
	static def logTrace(Object object, Object message) {
		Logger.getLogger(object.class).trace(message)
	}
	
	static def logDebug(Object object, Object message) {
		Logger.getLogger(object.class).debug(message)
	}
	
	static def logInfo(Object object, Object message) {
		Logger.getLogger(object.class).info(message)
	}
	
	static def logWarn(Object object, Object message) {
		Logger.getLogger(object.class).warn(message)
	}
	
	static def logError(Object object, Object message) {
		Logger.getLogger(object.class).error(message)
	}
	
	static def logFatal(Object object, Object message) {
		Logger.getLogger(object.class).fatal(message)
	}
	
}