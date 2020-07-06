package de.joneug.mdal.generator;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Optional;
import java.util.TreeSet;

import org.eclipse.emf.ecore.EObject;
import org.eclipse.xtext.generator.IFileSystemAccess2;
import org.eclipse.xtext.generator.JavaIoFileSystemAccess;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import de.joneug.al.ObjectRange;
import de.joneug.al.SymbolReference;
import de.joneug.mdal.extensions.ObjectExtensions;
import de.joneug.mdal.mdal.Entity;
import de.joneug.mdal.mdal.TypeEnum;
import de.joneug.mdal.util.MdalUtils;

public class GeneratorManagement {

	protected static GeneratorManagement instance;

	public static GeneratorManagement getInstance() {
		if (instance == null) {
			instance = new GeneratorManagement();
		}

		return instance;
	}

	enum ALObjectType {
		TABLE, PAGE, CODEUNIT, ENUM, TABLE_EXT, ENUM_EXT
	}

	protected TreeSet<ObjectRange> alObjectRanges;
	protected HashMap<EObject, Integer> assignedObjectNoMap;
	protected HashMap<EObject, Integer> lastFieldNoMap;
	protected HashMap<EObject, Integer> lastKeyNoMap;
	protected HashMap<ALObjectType, Integer> lastALObjectNoMap;
	protected List<SymbolReference> symbolReferences;
	protected IFileSystemAccess2 fsa;
	protected IFileSystemAccess2 generatorFsa;

	protected GeneratorManagement() {
		alObjectRanges = new TreeSet<ObjectRange>();
		lastFieldNoMap = new HashMap<EObject, Integer>();
		lastKeyNoMap = new HashMap<EObject, Integer>();
		lastALObjectNoMap = new HashMap<ALObjectType, Integer>();
		assignedObjectNoMap = new HashMap<EObject, Integer>();
		symbolReferences = new ArrayList<SymbolReference>();
	}

	public void initializeFileSystemAccess() {
		JavaIoFileSystemAccess javaFsa = MdalUtils.getJavaIoFileSystemAccess();
		javaFsa.setOutputPath(".");
		this.fsa = javaFsa;
	}
	
	public void initializeFileSystemAccess(IFileSystemAccess2 fsa) {
		this.fsa = fsa;
	}
	
	protected void ensureFileSystemAccess() {
		if(this.fsa == null) {
			initializeFileSystemAccess();
		}
	}
	
	public void setGeneratorFsa(IFileSystemAccess2 generatorFsa) {
		this.generatorFsa = generatorFsa;
	}
	
	public IFileSystemAccess2 getGeneratorFsa() {
		return this.generatorFsa;
	}

	public synchronized void readAppJson() {	
		alObjectRanges.clear();
		ensureFileSystemAccess();
		
		Gson gson = new Gson();
		String jsonString = this.fsa.readTextFile(MdalGenerator.APP_JSON_FILENAME).toString();
		JsonObject jsonObject = JsonParser.parseString(jsonString).getAsJsonObject();
		ObjectRange[] objectRanges = gson.fromJson(jsonObject.get("idRanges"), ObjectRange[].class);
		Arrays.stream(objectRanges).forEach(this::addObjectRange);

		ObjectExtensions.logInfo(this, "Parsed object ranges " + getObjectRanges());
	}

	public synchronized void readSymbolReferences() {
		readSymbolReferences(".alpackages");
	}

	protected void readSymbolReferences(String directory) {		
		if(!new File(directory).exists()) {
			ObjectExtensions.logInfo(this, "No symbol references found");
			this.symbolReferences.clear();
			return;
		}
		
		List<SymbolReference> symbolReferencesNew = new ArrayList<SymbolReference>();
		
		for (File file : new File(directory).listFiles((d, name) -> name.endsWith(".app"))) {
			Optional<SymbolReference> symbolReference = this.symbolReferences.stream().
					parallel().filter(it -> it.hashCode() == MdalUtils.calcFileHashCode(file)).findAny();
			
			if (symbolReference.isPresent()) {
				ObjectExtensions.logDebug(this, "App file " + file.getName() + " has already been parsed");
				symbolReferencesNew.add(symbolReference.get());
				
			} else {
				try {
					ObjectExtensions.logInfo(this, "Parsing app file " + file.getName());
					symbolReferencesNew.add(SymbolReference.parseFile(file));
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		
		this.symbolReferences = symbolReferencesNew;
	}

	public void reset() {
		lastFieldNoMap.clear();
		lastKeyNoMap.clear();
		lastALObjectNoMap.clear();
	}
	
	public List<SymbolReference> getSymbolReferences() {
		return this.symbolReferences;
	}

	public void addObjectRange(ObjectRange objectRange) {
		alObjectRanges.add(objectRange);
	}

	public TreeSet<ObjectRange> getObjectRanges() {
		return this.alObjectRanges;
	}

	public int getNewFieldNo(EObject object) {
		if (!lastFieldNoMap.containsKey(object)) {
			if (object instanceof TypeEnum) {
				lastFieldNoMap.put(object, 0);
			} else {
				lastFieldNoMap.put(object, 1);
			}
		} else {
			lastFieldNoMap.put(object, lastFieldNoMap.get(object) + 1);
		}

		return lastFieldNoMap.get(object);
	}

	public int getLastFieldNo(EObject object) {
		if (!lastFieldNoMap.containsKey(object)) {
			return -1;
		} else {
			return lastFieldNoMap.get(object);
		}
	}
	
	public int getNewKeyNo(EObject object) {
		if (!lastKeyNoMap.containsKey(object)) {
			lastKeyNoMap.put(object, 1);
		} else {
			lastKeyNoMap.put(object, lastKeyNoMap.get(object) + 1);
		}

		return lastKeyNoMap.get(object);
	}

	public int getLastKeyNo(EObject object) {
		if (!lastKeyNoMap.containsKey(object)) {
			return -1;
		} else {
			return lastKeyNoMap.get(object);
		}
	}
	
	public int getTableNo(Entity entity) {
		if(!assignedObjectNoMap.containsKey(entity)) {
			return -1;
		} else {
			return assignedObjectNoMap.get(entity);
		}
	}

	public int getNewTableNo(Entity entity) {
		int objectNo = getNewObjectNo(ALObjectType.TABLE);
		
		assignedObjectNoMap.put(entity, objectNo);
		
		return objectNo;
	}
	
	public int getNewTableNo() {
		return getNewObjectNo(ALObjectType.TABLE);
	}

	public int getNewPageNo() {
		return getNewObjectNo(ALObjectType.PAGE);
	}
	
	public int getLastPageNo() {
		return getLastObjectNo(ALObjectType.PAGE);
	}

	public int getNewCodeunitNo() {
		return getNewObjectNo(ALObjectType.CODEUNIT);
	}

	public int getNewEnumNo() {
		return getNewObjectNo(ALObjectType.ENUM);
	}

	public int getNewTableExtNo() {
		return getNewObjectNo(ALObjectType.TABLE_EXT);
	}

	public int getNewEnumExtNo() {
		return getNewObjectNo(ALObjectType.ENUM_EXT);
	}

	protected int getNewObjectNo(ALObjectType objectType) {
		int newObjectNo;

		if (!lastALObjectNoMap.containsKey(objectType)) {
			newObjectNo = getNewObjectNo(-1);
		} else {
			newObjectNo = getNewObjectNo(lastALObjectNoMap.get(objectType));
		}

		lastALObjectNoMap.put(objectType, newObjectNo);

		return newObjectNo;
	}

	protected int getNewObjectNo(int lastObjectNo) {
		if (lastObjectNo == -1) {
			return alObjectRanges.first().getMinValue();
		}

		for (ObjectRange objectRange : alObjectRanges) {
			if (objectRange.isInRange(lastObjectNo) && objectRange.isSpaceLeft(lastObjectNo)) {
				return lastObjectNo + 1;
			} else if (objectRange.isSpaceLeft(lastObjectNo)) {
				return objectRange.getMinValue();
			}
		}

		throw new RuntimeException("No Object IDs left. Please add ID ranges in app.json.");
	}
	
	protected int getLastObjectNo(ALObjectType objectType) {
		if (!lastALObjectNoMap.containsKey(objectType)) {
			return -1;
		} else {
			return lastALObjectNoMap.get(objectType);
		}
	}

}
