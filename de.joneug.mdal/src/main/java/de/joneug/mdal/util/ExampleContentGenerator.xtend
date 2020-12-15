package de.joneug.mdal.util

class ExampleContentGenerator {
	
	static def generateMinimalModel() '''
		solution "Seminar Management" {
			Prefix = "SEM";
			
			master "Seminar" {
				ShortName = "Sem.";
				
				fields {
					template("Description"; Description)
					field("Duration Days"; Decimal)
					template("Dimensions"; Dimensions)
				}
				
				cardPage {
					group("General") {
						field("Description")
						field("Duration Days")
					}
						group("Posting Details") {
						field("Dimensions")
					}
				}
				
				listPage {
					field("Description")
					field("Duration Days")
				}
			}
		}
	'''

	static def generateCorrectModel() '''
		solution "Seminar Management" {
		    Prefix = "SEM";
		
		    master "Seminar" {
		        ShortName = "Sem.";
		
		        fields {
		            template("Description"; Description)
		            field("Duration Days"; Decimal)
		            field("Minimum Participants"; Integer)
		            field("Maximum Participants"; Integer)
		            field("Language Code"; Code[10])
		            field("Seminar Price"; Decimal)
		            field("Gen. Prod. Posting Group"; Code[20])
		            template("Dimensions"; Dimensions)
		        }
		
		        cardPage {
		            group("General") {
		                field("Description")
		                field("Duration Days")
		                field("Minimum Participants")
		                field("Maximum Participants")
		                field("Language Code")
		            }
		            group("Posting Details") {
		                field("Gen. Prod. Posting Group")
		                field("Seminar Price")
		                field("Dimensions")
		            }
		        }
		
		        listPage {
		            field("Description")
		            field("Duration Days")
		            field("Minimum Participants")
		            field("Maximum Participants")
		            field("Seminar Price")
		            field("Language Code")
		        }
		    }
		
		    supplemental "Instructor" {
		        ShortName = "Inst.";
		
		        fields {
		            template("Name"; Name)
		            template("Contact Information"; ContactInfo)
		            field("Contact No."; Code[20])
		            field("Resource No."; Code[20])
		            field("Internal/External"; Option[" ", "Internal", "External"])
		            template("Salesperson"; Salesperson)
		            field("Language Code"; Code[10])
		            template("Dimensions"; Dimensions)
		        }
		
		        listPage {
		            field("Internal/External")
		            field("Name")
		            field("Contact Information")
		            field("Contact No.")
		            field("Resource No.")
		            field("Salesperson")
		            field("Language Code")
		        }
		    }
		
		    supplemental "Seminar Room" {
		        ShortName = "Sem. Room";
		
		        fields {
		            template("Name"; Name)
		            template("Address"; Address)
		            template("Contact Information"; ContactInfo)
		            template("Salesperson"; Salesperson)
		            field("Resource No."; Code[20])
		            field("Internal/External"; Option[" ", "Internal", "External"])
		            field("Maximum Participants"; Integer)
		            template("Dimensions"; Dimensions)
		        }
		
		        listPage {
		            field("Internal/External")
		            field("Name")
		            field("Resource No.")
		            field("Maximum Participants")
		            field("Address")
		            field("Contact Information")
		            field("Salesperson")
		        }
		    }
		
		    document "Seminar Registration" {
		        ShortName = "Sem. Reg.";
		
		        header "Seminar Registration Header" {
		            ShortName = "Sem. Reg. Header";
		            StatusCaptions = ["Planning", "Registration", "Closed", "Canceled"];
		
		            fields {
		                field("Starting Date"; Date)
		                include("Seminar No."; "Seminar"."No.")
		                include("Seminar Description"; "Seminar"."Description")
		                include("Instructor Code"; "Instructor"."Code")
		                include("Duration Days"; "Seminar"."Duration Days")
		                include("Minimum Participants"; "Seminar"."Minimum Participants")
		                include("Maximum Participants"; "Seminar"."Maximum Participants")
		                include("Language Code"; "Seminar"."Language Code")
		                include("Seminar Price"; "Seminar"."Seminar Price") {
		                    Validate = true;
		                }
		                include("Gen. Prod. Posting Group"; "Seminar"."Gen. Prod. Posting Group")
		                template("Salesperson"; Salesperson)
		                include("Room Code"; "Seminar Room"."Code")
		                include("Room Name"; "Seminar Room"."Name")
		                include("Room Address"; "Seminar Room"."Address")
		                include("Room Contact Information"; "Seminar Room"."Contact Information")
		                include("Dimensions"; "Seminar"."Dimensions")
		            }
		
		            documentPage {
		                group("General") {
		                    field("Starting Date")
		                    field("Seminar No.")
		                    field("Seminar Description")
		                    field("Instructor Code")
		                    field("Duration Days")
		                    field("Minimum Participants")
		                    field("Maximum Participants")
		                    field("Language Code")
		                    field("Salesperson")
		                }
		                group("Seminar Room") {
		                    field("Room Code")
		                    field("Room Name")
		                    field("Room Contact Information")
		                    field("Room Address")
		                }
		                group("Invoicing") {
		                    field("Gen. Prod. Posting Group")
		                    field("Dimensions")
		                    field("Seminar Price")
		                }
		            }
		
		            listPage {
		                field("Starting Date")
		                field("Seminar Description")
		                field("Instructor Code")
		                field("Room Code")
		            }
		        }
		
		        line "Seminar Registration Line" {
		            ShortName = "Sem. Reg. Line";
		
		            fields {
		                field("Bill-to Customer No."; Code[20])
		                template("Participant Contact No."; Contact)
		                field("Registration Date"; Date)
		                field("To Invoice"; Boolean)
		                field("Participated"; Boolean)
		                field("Confirmation Date"; Date)
		                field("Seminar Price"; Decimal)
		                field("Line Discount %"; Decimal)
		                field("Line Discount Amount (LCY)"; Decimal)
		                field("Line Amount (LCY)"; Decimal)
		                field("Registered"; Boolean)
		                field("Gen. Bus. Posting Group"; Code[20])
		                field("External Document No."; Code[35])
		                template("Dimensions"; Dimensions)
		            }
		
		            listPartPage {
		                field("Bill-to Customer No.")
		                field("Participant Contact No.")
		                field("Registration Date")
		                field("Registered")
		                field("Participated")
		                field("To Invoice")
		                field("Confirmation Date")
		                field("Seminar Price")
		                field("Line Discount %")
		                field("Line Discount Amount (LCY)")
		                field("Line Amount (LCY)")
		                field("External Document No.")
		                field("Dimensions")
		            }
		        }
		    }
		
		    ledgerEntry "Seminar Ledger Entry" {
		        ShortName = "Sem. Ledger Entry";
		
		        fields {
		            field("Entry Type"; Enum["Registration"])
		            include("Bill-to Customer No."; "Seminar Registration Line"."Bill-to Customer No.")
		            field("Charge Type"; Enum["Instructor", "Room", "Participant"])
		            field("Quantity"; Decimal)
		            field("Unit Price"; Decimal)
		            field("Total Price"; Decimal)
		            include("Participant Contact No."; "Seminar Registration Line"."Participant Contact No.")
		            field("Participant Name"; Text[50])
		            field("Chargeable"; Boolean)
		            include("Seminar Room Code"; "Seminar Room"."Code")
		            include("Instructor Code"; "Instructor"."Code")
		            include("Starting Date"; "Seminar Registration Header"."Starting Date")
		            field("Res. Ledger Entry No."; Integer)
		            field("Source Type"; Enum[" ", "Seminar Registration"])
		        }
		
		        listPage {
		            field("Entry Type")
		            field("Participant Contact No.")
		            field("Participant Name")
		            field("Bill-to Customer No.")
		            field("Starting Date")
		            field("Quantity")
		            field("Unit Price")
		            field("Total Price")
		            field("Charge Type")
		            field("Chargeable")
		            field("Seminar Room Code")
		            field("Instructor Code")
		        }
		    }
		}
	'''

	static def generateModelWithErrors() '''
		solution "Seminar Management" {
			Prefix = "SEM";
			
			master "Seminar" {
				ShortName = "Sem.";
				
				fields { 
					field("Picture"; Media)
					field("Duration Days"; Decimal)
					field("Minimum Participants"; Integer)
					field("Maximum Participants"; Integer)
					field("Language Code"; Code[10]) {
						TableRelation = "Language1";
					}
					field("Seminar Price"; Decimal)
					template("Seminar Price" ; Dimensions)
				}
				
				cardPage {
					group("General") {
						field("Duration Days")
					}
					group("General") {
						field("Duration Days")
					}
				}
			}
			
			document "Seminar Registration" {
				ShortName = "Sem. Reg.";
				
				header "Seminar Registration Header" {
					ShortName = "Sem. Reg. Header";
					StatusCaptions = ["Planning", "Registration", "Closed", "Canceled"];
				}
				
				line "Seminar Registration Header" {
					ShortName = "Sem. Reg. Line";
				}
			}
			
			ledgerEntry "Seminar Ledger Entry" {
				ShortName = "Sem. Ledger Entry";
				
				fields {
					field("Picture"; Media)
					include("Language Code"; "Seminar"."Language Code1")
					include("Language Code"; "Seminar"."Maximum Participants")
				}
				
				listPage {
					field("Picture")
					field("ABC")
					field("Language Code")
				}
			}
		}
	'''

	static def generateAppJson() '''
		{
			"id": "9b4b40f4-d5cd-44a6-b56f-5b08621190a7",
			"name": "Seminar Management (mdAL)",
			"publisher": "joneug",
			"version": "1.0.0.0",
			"brief": "",
			"description": "",
			"privacyStatement": "",
			"EULA": "",
			"help": "",
			"url": "",
			"logo": "",
			"dependencies": [
				{
					"id": "63ca2fa4-4f03-4f2b-a480-172fef340d3f",
					"publisher": "Microsoft",
					"name": "System Application",
					"version": "16.0.0.0"
				},
				{
					"id": "437dbf0e-84ff-417a-965d-ed2bb9650972",
					"publisher": "Microsoft",
					"name": "Base Application",
					"version": "16.0.0.0"
				}
			],
			"screenshots": [],
			"platform": "16.0.0.0",
			"idRanges": [
				{
					"from": 123456700,
					"to": 123456799
				},
				{
					"from": 123456800,
					"to": 123456899
				}
			],
			"contextSensitiveHelpUrl": "https://ALProject1.com/help/",
			"showMyCode": true,
			"runtime": "5.0"
		}
	'''

}
