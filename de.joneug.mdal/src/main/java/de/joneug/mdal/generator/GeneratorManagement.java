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
	protected HashMap<EObject, Integer> lastFieldNoMap;
	protected HashMap<ALObjectType, Integer> lastALObjectNoMap;
	protected List<SymbolReference> symbolReferences;
	protected IFileSystemAccess2 fsa;

	private GeneratorManagement() {
		alObjectRanges = new TreeSet<ObjectRange>();
		lastFieldNoMap = new HashMap<EObject, Integer>();
		lastALObjectNoMap = new HashMap<ALObjectType, Integer>();
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

	public void readAppJson() {		
		alObjectRanges.clear();
		ensureFileSystemAccess();
		
		Gson gson = new Gson();
		String jsonString = this.fsa.readTextFile(MdalGenerator.APP_JSON_FILENAME).toString();
		JsonObject jsonObject = JsonParser.parseString(jsonString).getAsJsonObject();
		ObjectRange[] objectRanges = gson.fromJson(jsonObject.get("idRanges"), ObjectRange[].class);
		Arrays.stream(objectRanges).forEach(this::addObjectRange);

		ObjectExtensions.logInfo(this, "Parsed object ranges " + getObjectRanges());
	}

	public void readSymbolReferences() {
		readSymbolReferences(".alpackages");
	}

	public void readSymbolReferences(String directory) {
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
				ObjectExtensions.logInfo(this, "App file " + file.getName() + " has already been parsed");
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
		lastALObjectNoMap.clear();
	}
	
	public List<SymbolReference> getSymbolReferences() {
		readSymbolReferences();
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

	public int getNewTableNo() {
		return getNewObjectNo(ALObjectType.TABLE);
	}

	public int getNewPageNo() {
		return getNewObjectNo(ALObjectType.PAGE);
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
			newObjectNo = lastALObjectNoMap.get(objectType) + 1;
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

}
