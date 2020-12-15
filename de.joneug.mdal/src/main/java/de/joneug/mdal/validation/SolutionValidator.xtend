package de.joneug.mdal.validation

import de.joneug.mdal.mdal.MdalPackage
import de.joneug.mdal.mdal.Solution
import org.eclipse.xtext.validation.AbstractDeclarativeValidator
import org.eclipse.xtext.validation.Check
import org.eclipse.xtext.validation.EValidatorRegistrar

class SolutionValidator extends AbstractDeclarativeValidator {

	override register(EValidatorRegistrar registrar) {}

	@Check
	def checkRequiredEntites(Solution solution) {
		if (solution.master === null && solution.document !== null) {
			error(
				'''A master entity corresponding to the document «solution.document.name» has to be defined.''',
				MdalPackage.Literals.SOLUTION__DOCUMENT,
				MdalValidator.DOCUMENT_NO_MASTER
			)
		}
		if (solution.document === null && solution.ledgerEntry !== null) {
			error(
				'''A document entity corresponding to the ledger entry «solution.ledgerEntry.name» has to be defined.''',
				MdalPackage.Literals.SOLUTION__LEDGER_ENTRY,
				MdalValidator.LEDGER_ENTRY_NO_DOCUMENT
			)
		}
	}

}
