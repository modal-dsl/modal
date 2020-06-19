package de.joneug.mdal.ide.test.util

class ExampleContentGenerator {

	static def generateCorrectModel() '''
		solution "Seminar Management" {
			Prefix = "SEM";
			
			   master "Seminar" {
			       ShortName = "Sem.";
			       NameInsteadDescr = false;
			       fields { 
			           field("Picture"; Media)
			           template("Gen. Product Posting Group" ; GenProductPostingGroup)
			           field("Duration Days"; Decimal)
			           field("Minimum Participants"; Integer)
			           field("Maximum Participants"; Integer)
			           field("Language Code"; Code[10])
			           field("Seminar Price"; Decimal)
			       }
			   }
		
		    journal {
		        fields {
		            include("Seminar"."Language Code")
		            field("Picture"; Media)
		        }
		    }
		}
	'''

	static def generateModelWithErrors() '''
		solution "Seminar Management" {
			Prefix = "SEM";
			
			   master "Seminar" {
			       ShortName = "Sem.";
			       NameInsteadDescr = false;
			       fields { 
			           field("Picture"; Media)
			           template("Gen. Product Posting Group" ; GenProductPostingGroup)
			           field("Duration Days"; Decimal)
			           field("Minimum Participants"; Integer)
			           field("Maximum Participants"; Integer)
			           field("Language Code"; Code[10])
			           field("Seminar Price"; Decimal)
			       }
			   }
		
		    journal {
		        fields {
		            include("Seminar"."Language Code1")
		            field("Picture"; Media)
		        }
		    }
		}
	'''

}
