package de.joneug.mdal.parser.antlr.internal;

import org.eclipse.xtext.*;
import org.eclipse.xtext.parser.*;
import org.eclipse.xtext.parser.impl.*;
import org.eclipse.emf.ecore.util.EcoreUtil;
import org.eclipse.emf.ecore.EObject;
import org.eclipse.emf.common.util.Enumerator;
import org.eclipse.xtext.parser.antlr.AbstractInternalAntlrParser;
import org.eclipse.xtext.parser.antlr.XtextTokenStream;
import org.eclipse.xtext.parser.antlr.XtextTokenStream.HiddenTokens;
import org.eclipse.xtext.parser.antlr.AntlrDatatypeRuleToken;
import de.joneug.mdal.services.MdalGrammarAccess;



import org.antlr.runtime.*;
import java.util.Stack;
import java.util.List;
import java.util.ArrayList;

@SuppressWarnings("all")
public class InternalMdalParser extends AbstractInternalAntlrParser {
    public static final String[] tokenNames = new String[] {
        "<invalid>", "<EOR>", "<DOWN>", "<UP>", "RULE_STRING", "RULE_INT", "RULE_ID", "RULE_ML_COMMENT", "RULE_SL_COMMENT", "RULE_WS", "RULE_ANY_OTHER", "'extension'", "'{'", "'id'", "'idRanges'", "'['", "','", "']'", "'platform'", "'publisher'", "'version'", "'brief'", "'description'", "'privacyStatement'", "'eula'", "'help'", "'url'", "'contextSensitiveHelpUrl'", "'showMyCode'", "'runtime'", "'}'", "'Text'", "'..'", "'true'", "'false'"
    };
    public static final int RULE_STRING=4;
    public static final int RULE_SL_COMMENT=8;
    public static final int T__19=19;
    public static final int T__15=15;
    public static final int T__16=16;
    public static final int T__17=17;
    public static final int T__18=18;
    public static final int T__11=11;
    public static final int T__33=33;
    public static final int T__12=12;
    public static final int T__34=34;
    public static final int T__13=13;
    public static final int T__14=14;
    public static final int EOF=-1;
    public static final int T__30=30;
    public static final int T__31=31;
    public static final int T__32=32;
    public static final int RULE_ID=6;
    public static final int RULE_WS=9;
    public static final int RULE_ANY_OTHER=10;
    public static final int T__26=26;
    public static final int T__27=27;
    public static final int T__28=28;
    public static final int RULE_INT=5;
    public static final int T__29=29;
    public static final int T__22=22;
    public static final int RULE_ML_COMMENT=7;
    public static final int T__23=23;
    public static final int T__24=24;
    public static final int T__25=25;
    public static final int T__20=20;
    public static final int T__21=21;

    // delegates
    // delegators


        public InternalMdalParser(TokenStream input) {
            this(input, new RecognizerSharedState());
        }
        public InternalMdalParser(TokenStream input, RecognizerSharedState state) {
            super(input, state);
             
        }
        

    public String[] getTokenNames() { return InternalMdalParser.tokenNames; }
    public String getGrammarFileName() { return "InternalMdal.g"; }



     	private MdalGrammarAccess grammarAccess;

        public InternalMdalParser(TokenStream input, MdalGrammarAccess grammarAccess) {
            this(input);
            this.grammarAccess = grammarAccess;
            registerRules(grammarAccess.getGrammar());
        }

        @Override
        protected String getFirstRuleName() {
        	return "Model";
       	}

       	@Override
       	protected MdalGrammarAccess getGrammarAccess() {
       		return grammarAccess;
       	}




    // $ANTLR start "entryRuleModel"
    // InternalMdal.g:65:1: entryRuleModel returns [EObject current=null] : iv_ruleModel= ruleModel EOF ;
    public final EObject entryRuleModel() throws RecognitionException {
        EObject current = null;

        EObject iv_ruleModel = null;


        try {
            // InternalMdal.g:65:46: (iv_ruleModel= ruleModel EOF )
            // InternalMdal.g:66:2: iv_ruleModel= ruleModel EOF
            {
             newCompositeNode(grammarAccess.getModelRule()); 
            pushFollow(FOLLOW_1);
            iv_ruleModel=ruleModel();

            state._fsp--;

             current =iv_ruleModel; 
            match(input,EOF,FOLLOW_2); 

            }

        }

            catch (RecognitionException re) {
                recover(input,re);
                appendSkippedTokens();
            }
        finally {
        }
        return current;
    }
    // $ANTLR end "entryRuleModel"


    // $ANTLR start "ruleModel"
    // InternalMdal.g:72:1: ruleModel returns [EObject current=null] : ( (lv_alExtensions_0_0= ruleAlExtension ) )* ;
    public final EObject ruleModel() throws RecognitionException {
        EObject current = null;

        EObject lv_alExtensions_0_0 = null;



        	enterRule();

        try {
            // InternalMdal.g:78:2: ( ( (lv_alExtensions_0_0= ruleAlExtension ) )* )
            // InternalMdal.g:79:2: ( (lv_alExtensions_0_0= ruleAlExtension ) )*
            {
            // InternalMdal.g:79:2: ( (lv_alExtensions_0_0= ruleAlExtension ) )*
            loop1:
            do {
                int alt1=2;
                int LA1_0 = input.LA(1);

                if ( (LA1_0==11) ) {
                    alt1=1;
                }


                switch (alt1) {
            	case 1 :
            	    // InternalMdal.g:80:3: (lv_alExtensions_0_0= ruleAlExtension )
            	    {
            	    // InternalMdal.g:80:3: (lv_alExtensions_0_0= ruleAlExtension )
            	    // InternalMdal.g:81:4: lv_alExtensions_0_0= ruleAlExtension
            	    {

            	    				newCompositeNode(grammarAccess.getModelAccess().getAlExtensionsAlExtensionParserRuleCall_0());
            	    			
            	    pushFollow(FOLLOW_3);
            	    lv_alExtensions_0_0=ruleAlExtension();

            	    state._fsp--;


            	    				if (current==null) {
            	    					current = createModelElementForParent(grammarAccess.getModelRule());
            	    				}
            	    				add(
            	    					current,
            	    					"alExtensions",
            	    					lv_alExtensions_0_0,
            	    					"de.joneug.mdal.Mdal.AlExtension");
            	    				afterParserOrEnumRuleCall();
            	    			

            	    }


            	    }
            	    break;

            	default :
            	    break loop1;
                }
            } while (true);


            }


            	leaveRule();

        }

            catch (RecognitionException re) {
                recover(input,re);
                appendSkippedTokens();
            }
        finally {
        }
        return current;
    }
    // $ANTLR end "ruleModel"


    // $ANTLR start "entryRuleAlExtension"
    // InternalMdal.g:101:1: entryRuleAlExtension returns [EObject current=null] : iv_ruleAlExtension= ruleAlExtension EOF ;
    public final EObject entryRuleAlExtension() throws RecognitionException {
        EObject current = null;

        EObject iv_ruleAlExtension = null;


        try {
            // InternalMdal.g:101:52: (iv_ruleAlExtension= ruleAlExtension EOF )
            // InternalMdal.g:102:2: iv_ruleAlExtension= ruleAlExtension EOF
            {
             newCompositeNode(grammarAccess.getAlExtensionRule()); 
            pushFollow(FOLLOW_1);
            iv_ruleAlExtension=ruleAlExtension();

            state._fsp--;

             current =iv_ruleAlExtension; 
            match(input,EOF,FOLLOW_2); 

            }

        }

            catch (RecognitionException re) {
                recover(input,re);
                appendSkippedTokens();
            }
        finally {
        }
        return current;
    }
    // $ANTLR end "entryRuleAlExtension"


    // $ANTLR start "ruleAlExtension"
    // InternalMdal.g:108:1: ruleAlExtension returns [EObject current=null] : (otherlv_0= 'extension' ( (lv_name_1_0= RULE_STRING ) ) otherlv_2= '{' (otherlv_3= 'id' ( (lv_id_4_0= RULE_STRING ) ) )? (otherlv_5= 'idRanges' otherlv_6= '[' ( ( (lv_idRanges_7_0= ruleIdRange ) ) (otherlv_8= ',' ( (lv_idRanges_9_0= ruleIdRange ) ) )* ) otherlv_10= ']' )? (otherlv_11= 'platform' ( (lv_platform_12_0= RULE_STRING ) ) )? (otherlv_13= 'publisher' ( (lv_publisher_14_0= RULE_STRING ) ) )? (otherlv_15= 'version' ( (lv_version_16_0= RULE_STRING ) ) )? (otherlv_17= 'brief' ( (lv_brief_18_0= RULE_STRING ) ) )? (otherlv_19= 'description' ( (lv_description_20_0= RULE_STRING ) ) )? (otherlv_21= 'privacyStatement' ( (lv_privacyStatement_22_0= RULE_STRING ) ) )? (otherlv_23= 'eula' ( (lv_eula_24_0= RULE_STRING ) ) )? (otherlv_25= 'help' ( (lv_help_26_0= RULE_STRING ) ) )? (otherlv_27= 'url' ( (lv_url_28_0= RULE_STRING ) ) )? (otherlv_29= 'contextSensitiveHelpUrl' ( (lv_contextSensitiveHelpUrl_30_0= RULE_STRING ) ) )? (otherlv_31= 'showMyCode' ( (lv_showMyCode_32_0= ruleBool ) ) )? (otherlv_33= 'runtime' ( (lv_runtime_34_0= RULE_STRING ) ) )? otherlv_35= '}' ) ;
    public final EObject ruleAlExtension() throws RecognitionException {
        EObject current = null;

        Token otherlv_0=null;
        Token lv_name_1_0=null;
        Token otherlv_2=null;
        Token otherlv_3=null;
        Token lv_id_4_0=null;
        Token otherlv_5=null;
        Token otherlv_6=null;
        Token otherlv_8=null;
        Token otherlv_10=null;
        Token otherlv_11=null;
        Token lv_platform_12_0=null;
        Token otherlv_13=null;
        Token lv_publisher_14_0=null;
        Token otherlv_15=null;
        Token lv_version_16_0=null;
        Token otherlv_17=null;
        Token lv_brief_18_0=null;
        Token otherlv_19=null;
        Token lv_description_20_0=null;
        Token otherlv_21=null;
        Token lv_privacyStatement_22_0=null;
        Token otherlv_23=null;
        Token lv_eula_24_0=null;
        Token otherlv_25=null;
        Token lv_help_26_0=null;
        Token otherlv_27=null;
        Token lv_url_28_0=null;
        Token otherlv_29=null;
        Token lv_contextSensitiveHelpUrl_30_0=null;
        Token otherlv_31=null;
        Token otherlv_33=null;
        Token lv_runtime_34_0=null;
        Token otherlv_35=null;
        EObject lv_idRanges_7_0 = null;

        EObject lv_idRanges_9_0 = null;

        Enumerator lv_showMyCode_32_0 = null;



        	enterRule();

        try {
            // InternalMdal.g:114:2: ( (otherlv_0= 'extension' ( (lv_name_1_0= RULE_STRING ) ) otherlv_2= '{' (otherlv_3= 'id' ( (lv_id_4_0= RULE_STRING ) ) )? (otherlv_5= 'idRanges' otherlv_6= '[' ( ( (lv_idRanges_7_0= ruleIdRange ) ) (otherlv_8= ',' ( (lv_idRanges_9_0= ruleIdRange ) ) )* ) otherlv_10= ']' )? (otherlv_11= 'platform' ( (lv_platform_12_0= RULE_STRING ) ) )? (otherlv_13= 'publisher' ( (lv_publisher_14_0= RULE_STRING ) ) )? (otherlv_15= 'version' ( (lv_version_16_0= RULE_STRING ) ) )? (otherlv_17= 'brief' ( (lv_brief_18_0= RULE_STRING ) ) )? (otherlv_19= 'description' ( (lv_description_20_0= RULE_STRING ) ) )? (otherlv_21= 'privacyStatement' ( (lv_privacyStatement_22_0= RULE_STRING ) ) )? (otherlv_23= 'eula' ( (lv_eula_24_0= RULE_STRING ) ) )? (otherlv_25= 'help' ( (lv_help_26_0= RULE_STRING ) ) )? (otherlv_27= 'url' ( (lv_url_28_0= RULE_STRING ) ) )? (otherlv_29= 'contextSensitiveHelpUrl' ( (lv_contextSensitiveHelpUrl_30_0= RULE_STRING ) ) )? (otherlv_31= 'showMyCode' ( (lv_showMyCode_32_0= ruleBool ) ) )? (otherlv_33= 'runtime' ( (lv_runtime_34_0= RULE_STRING ) ) )? otherlv_35= '}' ) )
            // InternalMdal.g:115:2: (otherlv_0= 'extension' ( (lv_name_1_0= RULE_STRING ) ) otherlv_2= '{' (otherlv_3= 'id' ( (lv_id_4_0= RULE_STRING ) ) )? (otherlv_5= 'idRanges' otherlv_6= '[' ( ( (lv_idRanges_7_0= ruleIdRange ) ) (otherlv_8= ',' ( (lv_idRanges_9_0= ruleIdRange ) ) )* ) otherlv_10= ']' )? (otherlv_11= 'platform' ( (lv_platform_12_0= RULE_STRING ) ) )? (otherlv_13= 'publisher' ( (lv_publisher_14_0= RULE_STRING ) ) )? (otherlv_15= 'version' ( (lv_version_16_0= RULE_STRING ) ) )? (otherlv_17= 'brief' ( (lv_brief_18_0= RULE_STRING ) ) )? (otherlv_19= 'description' ( (lv_description_20_0= RULE_STRING ) ) )? (otherlv_21= 'privacyStatement' ( (lv_privacyStatement_22_0= RULE_STRING ) ) )? (otherlv_23= 'eula' ( (lv_eula_24_0= RULE_STRING ) ) )? (otherlv_25= 'help' ( (lv_help_26_0= RULE_STRING ) ) )? (otherlv_27= 'url' ( (lv_url_28_0= RULE_STRING ) ) )? (otherlv_29= 'contextSensitiveHelpUrl' ( (lv_contextSensitiveHelpUrl_30_0= RULE_STRING ) ) )? (otherlv_31= 'showMyCode' ( (lv_showMyCode_32_0= ruleBool ) ) )? (otherlv_33= 'runtime' ( (lv_runtime_34_0= RULE_STRING ) ) )? otherlv_35= '}' )
            {
            // InternalMdal.g:115:2: (otherlv_0= 'extension' ( (lv_name_1_0= RULE_STRING ) ) otherlv_2= '{' (otherlv_3= 'id' ( (lv_id_4_0= RULE_STRING ) ) )? (otherlv_5= 'idRanges' otherlv_6= '[' ( ( (lv_idRanges_7_0= ruleIdRange ) ) (otherlv_8= ',' ( (lv_idRanges_9_0= ruleIdRange ) ) )* ) otherlv_10= ']' )? (otherlv_11= 'platform' ( (lv_platform_12_0= RULE_STRING ) ) )? (otherlv_13= 'publisher' ( (lv_publisher_14_0= RULE_STRING ) ) )? (otherlv_15= 'version' ( (lv_version_16_0= RULE_STRING ) ) )? (otherlv_17= 'brief' ( (lv_brief_18_0= RULE_STRING ) ) )? (otherlv_19= 'description' ( (lv_description_20_0= RULE_STRING ) ) )? (otherlv_21= 'privacyStatement' ( (lv_privacyStatement_22_0= RULE_STRING ) ) )? (otherlv_23= 'eula' ( (lv_eula_24_0= RULE_STRING ) ) )? (otherlv_25= 'help' ( (lv_help_26_0= RULE_STRING ) ) )? (otherlv_27= 'url' ( (lv_url_28_0= RULE_STRING ) ) )? (otherlv_29= 'contextSensitiveHelpUrl' ( (lv_contextSensitiveHelpUrl_30_0= RULE_STRING ) ) )? (otherlv_31= 'showMyCode' ( (lv_showMyCode_32_0= ruleBool ) ) )? (otherlv_33= 'runtime' ( (lv_runtime_34_0= RULE_STRING ) ) )? otherlv_35= '}' )
            // InternalMdal.g:116:3: otherlv_0= 'extension' ( (lv_name_1_0= RULE_STRING ) ) otherlv_2= '{' (otherlv_3= 'id' ( (lv_id_4_0= RULE_STRING ) ) )? (otherlv_5= 'idRanges' otherlv_6= '[' ( ( (lv_idRanges_7_0= ruleIdRange ) ) (otherlv_8= ',' ( (lv_idRanges_9_0= ruleIdRange ) ) )* ) otherlv_10= ']' )? (otherlv_11= 'platform' ( (lv_platform_12_0= RULE_STRING ) ) )? (otherlv_13= 'publisher' ( (lv_publisher_14_0= RULE_STRING ) ) )? (otherlv_15= 'version' ( (lv_version_16_0= RULE_STRING ) ) )? (otherlv_17= 'brief' ( (lv_brief_18_0= RULE_STRING ) ) )? (otherlv_19= 'description' ( (lv_description_20_0= RULE_STRING ) ) )? (otherlv_21= 'privacyStatement' ( (lv_privacyStatement_22_0= RULE_STRING ) ) )? (otherlv_23= 'eula' ( (lv_eula_24_0= RULE_STRING ) ) )? (otherlv_25= 'help' ( (lv_help_26_0= RULE_STRING ) ) )? (otherlv_27= 'url' ( (lv_url_28_0= RULE_STRING ) ) )? (otherlv_29= 'contextSensitiveHelpUrl' ( (lv_contextSensitiveHelpUrl_30_0= RULE_STRING ) ) )? (otherlv_31= 'showMyCode' ( (lv_showMyCode_32_0= ruleBool ) ) )? (otherlv_33= 'runtime' ( (lv_runtime_34_0= RULE_STRING ) ) )? otherlv_35= '}'
            {
            otherlv_0=(Token)match(input,11,FOLLOW_4); 

            			newLeafNode(otherlv_0, grammarAccess.getAlExtensionAccess().getExtensionKeyword_0());
            		
            // InternalMdal.g:120:3: ( (lv_name_1_0= RULE_STRING ) )
            // InternalMdal.g:121:4: (lv_name_1_0= RULE_STRING )
            {
            // InternalMdal.g:121:4: (lv_name_1_0= RULE_STRING )
            // InternalMdal.g:122:5: lv_name_1_0= RULE_STRING
            {
            lv_name_1_0=(Token)match(input,RULE_STRING,FOLLOW_5); 

            					newLeafNode(lv_name_1_0, grammarAccess.getAlExtensionAccess().getNameSTRINGTerminalRuleCall_1_0());
            				

            					if (current==null) {
            						current = createModelElement(grammarAccess.getAlExtensionRule());
            					}
            					setWithLastConsumed(
            						current,
            						"name",
            						lv_name_1_0,
            						"org.eclipse.xtext.common.Terminals.STRING");
            				

            }


            }

            otherlv_2=(Token)match(input,12,FOLLOW_6); 

            			newLeafNode(otherlv_2, grammarAccess.getAlExtensionAccess().getLeftCurlyBracketKeyword_2());
            		
            // InternalMdal.g:142:3: (otherlv_3= 'id' ( (lv_id_4_0= RULE_STRING ) ) )?
            int alt2=2;
            int LA2_0 = input.LA(1);

            if ( (LA2_0==13) ) {
                alt2=1;
            }
            switch (alt2) {
                case 1 :
                    // InternalMdal.g:143:4: otherlv_3= 'id' ( (lv_id_4_0= RULE_STRING ) )
                    {
                    otherlv_3=(Token)match(input,13,FOLLOW_4); 

                    				newLeafNode(otherlv_3, grammarAccess.getAlExtensionAccess().getIdKeyword_3_0());
                    			
                    // InternalMdal.g:147:4: ( (lv_id_4_0= RULE_STRING ) )
                    // InternalMdal.g:148:5: (lv_id_4_0= RULE_STRING )
                    {
                    // InternalMdal.g:148:5: (lv_id_4_0= RULE_STRING )
                    // InternalMdal.g:149:6: lv_id_4_0= RULE_STRING
                    {
                    lv_id_4_0=(Token)match(input,RULE_STRING,FOLLOW_7); 

                    						newLeafNode(lv_id_4_0, grammarAccess.getAlExtensionAccess().getIdSTRINGTerminalRuleCall_3_1_0());
                    					

                    						if (current==null) {
                    							current = createModelElement(grammarAccess.getAlExtensionRule());
                    						}
                    						setWithLastConsumed(
                    							current,
                    							"id",
                    							lv_id_4_0,
                    							"org.eclipse.xtext.common.Terminals.STRING");
                    					

                    }


                    }


                    }
                    break;

            }

            // InternalMdal.g:166:3: (otherlv_5= 'idRanges' otherlv_6= '[' ( ( (lv_idRanges_7_0= ruleIdRange ) ) (otherlv_8= ',' ( (lv_idRanges_9_0= ruleIdRange ) ) )* ) otherlv_10= ']' )?
            int alt4=2;
            int LA4_0 = input.LA(1);

            if ( (LA4_0==14) ) {
                alt4=1;
            }
            switch (alt4) {
                case 1 :
                    // InternalMdal.g:167:4: otherlv_5= 'idRanges' otherlv_6= '[' ( ( (lv_idRanges_7_0= ruleIdRange ) ) (otherlv_8= ',' ( (lv_idRanges_9_0= ruleIdRange ) ) )* ) otherlv_10= ']'
                    {
                    otherlv_5=(Token)match(input,14,FOLLOW_8); 

                    				newLeafNode(otherlv_5, grammarAccess.getAlExtensionAccess().getIdRangesKeyword_4_0());
                    			
                    otherlv_6=(Token)match(input,15,FOLLOW_9); 

                    				newLeafNode(otherlv_6, grammarAccess.getAlExtensionAccess().getLeftSquareBracketKeyword_4_1());
                    			
                    // InternalMdal.g:175:4: ( ( (lv_idRanges_7_0= ruleIdRange ) ) (otherlv_8= ',' ( (lv_idRanges_9_0= ruleIdRange ) ) )* )
                    // InternalMdal.g:176:5: ( (lv_idRanges_7_0= ruleIdRange ) ) (otherlv_8= ',' ( (lv_idRanges_9_0= ruleIdRange ) ) )*
                    {
                    // InternalMdal.g:176:5: ( (lv_idRanges_7_0= ruleIdRange ) )
                    // InternalMdal.g:177:6: (lv_idRanges_7_0= ruleIdRange )
                    {
                    // InternalMdal.g:177:6: (lv_idRanges_7_0= ruleIdRange )
                    // InternalMdal.g:178:7: lv_idRanges_7_0= ruleIdRange
                    {

                    							newCompositeNode(grammarAccess.getAlExtensionAccess().getIdRangesIdRangeParserRuleCall_4_2_0_0());
                    						
                    pushFollow(FOLLOW_10);
                    lv_idRanges_7_0=ruleIdRange();

                    state._fsp--;


                    							if (current==null) {
                    								current = createModelElementForParent(grammarAccess.getAlExtensionRule());
                    							}
                    							add(
                    								current,
                    								"idRanges",
                    								lv_idRanges_7_0,
                    								"de.joneug.mdal.Mdal.IdRange");
                    							afterParserOrEnumRuleCall();
                    						

                    }


                    }

                    // InternalMdal.g:195:5: (otherlv_8= ',' ( (lv_idRanges_9_0= ruleIdRange ) ) )*
                    loop3:
                    do {
                        int alt3=2;
                        int LA3_0 = input.LA(1);

                        if ( (LA3_0==16) ) {
                            alt3=1;
                        }


                        switch (alt3) {
                    	case 1 :
                    	    // InternalMdal.g:196:6: otherlv_8= ',' ( (lv_idRanges_9_0= ruleIdRange ) )
                    	    {
                    	    otherlv_8=(Token)match(input,16,FOLLOW_9); 

                    	    						newLeafNode(otherlv_8, grammarAccess.getAlExtensionAccess().getCommaKeyword_4_2_1_0());
                    	    					
                    	    // InternalMdal.g:200:6: ( (lv_idRanges_9_0= ruleIdRange ) )
                    	    // InternalMdal.g:201:7: (lv_idRanges_9_0= ruleIdRange )
                    	    {
                    	    // InternalMdal.g:201:7: (lv_idRanges_9_0= ruleIdRange )
                    	    // InternalMdal.g:202:8: lv_idRanges_9_0= ruleIdRange
                    	    {

                    	    								newCompositeNode(grammarAccess.getAlExtensionAccess().getIdRangesIdRangeParserRuleCall_4_2_1_1_0());
                    	    							
                    	    pushFollow(FOLLOW_10);
                    	    lv_idRanges_9_0=ruleIdRange();

                    	    state._fsp--;


                    	    								if (current==null) {
                    	    									current = createModelElementForParent(grammarAccess.getAlExtensionRule());
                    	    								}
                    	    								add(
                    	    									current,
                    	    									"idRanges",
                    	    									lv_idRanges_9_0,
                    	    									"de.joneug.mdal.Mdal.IdRange");
                    	    								afterParserOrEnumRuleCall();
                    	    							

                    	    }


                    	    }


                    	    }
                    	    break;

                    	default :
                    	    break loop3;
                        }
                    } while (true);


                    }

                    otherlv_10=(Token)match(input,17,FOLLOW_11); 

                    				newLeafNode(otherlv_10, grammarAccess.getAlExtensionAccess().getRightSquareBracketKeyword_4_3());
                    			

                    }
                    break;

            }

            // InternalMdal.g:226:3: (otherlv_11= 'platform' ( (lv_platform_12_0= RULE_STRING ) ) )?
            int alt5=2;
            int LA5_0 = input.LA(1);

            if ( (LA5_0==18) ) {
                alt5=1;
            }
            switch (alt5) {
                case 1 :
                    // InternalMdal.g:227:4: otherlv_11= 'platform' ( (lv_platform_12_0= RULE_STRING ) )
                    {
                    otherlv_11=(Token)match(input,18,FOLLOW_4); 

                    				newLeafNode(otherlv_11, grammarAccess.getAlExtensionAccess().getPlatformKeyword_5_0());
                    			
                    // InternalMdal.g:231:4: ( (lv_platform_12_0= RULE_STRING ) )
                    // InternalMdal.g:232:5: (lv_platform_12_0= RULE_STRING )
                    {
                    // InternalMdal.g:232:5: (lv_platform_12_0= RULE_STRING )
                    // InternalMdal.g:233:6: lv_platform_12_0= RULE_STRING
                    {
                    lv_platform_12_0=(Token)match(input,RULE_STRING,FOLLOW_12); 

                    						newLeafNode(lv_platform_12_0, grammarAccess.getAlExtensionAccess().getPlatformSTRINGTerminalRuleCall_5_1_0());
                    					

                    						if (current==null) {
                    							current = createModelElement(grammarAccess.getAlExtensionRule());
                    						}
                    						setWithLastConsumed(
                    							current,
                    							"platform",
                    							lv_platform_12_0,
                    							"org.eclipse.xtext.common.Terminals.STRING");
                    					

                    }


                    }


                    }
                    break;

            }

            // InternalMdal.g:250:3: (otherlv_13= 'publisher' ( (lv_publisher_14_0= RULE_STRING ) ) )?
            int alt6=2;
            int LA6_0 = input.LA(1);

            if ( (LA6_0==19) ) {
                alt6=1;
            }
            switch (alt6) {
                case 1 :
                    // InternalMdal.g:251:4: otherlv_13= 'publisher' ( (lv_publisher_14_0= RULE_STRING ) )
                    {
                    otherlv_13=(Token)match(input,19,FOLLOW_4); 

                    				newLeafNode(otherlv_13, grammarAccess.getAlExtensionAccess().getPublisherKeyword_6_0());
                    			
                    // InternalMdal.g:255:4: ( (lv_publisher_14_0= RULE_STRING ) )
                    // InternalMdal.g:256:5: (lv_publisher_14_0= RULE_STRING )
                    {
                    // InternalMdal.g:256:5: (lv_publisher_14_0= RULE_STRING )
                    // InternalMdal.g:257:6: lv_publisher_14_0= RULE_STRING
                    {
                    lv_publisher_14_0=(Token)match(input,RULE_STRING,FOLLOW_13); 

                    						newLeafNode(lv_publisher_14_0, grammarAccess.getAlExtensionAccess().getPublisherSTRINGTerminalRuleCall_6_1_0());
                    					

                    						if (current==null) {
                    							current = createModelElement(grammarAccess.getAlExtensionRule());
                    						}
                    						setWithLastConsumed(
                    							current,
                    							"publisher",
                    							lv_publisher_14_0,
                    							"org.eclipse.xtext.common.Terminals.STRING");
                    					

                    }


                    }


                    }
                    break;

            }

            // InternalMdal.g:274:3: (otherlv_15= 'version' ( (lv_version_16_0= RULE_STRING ) ) )?
            int alt7=2;
            int LA7_0 = input.LA(1);

            if ( (LA7_0==20) ) {
                alt7=1;
            }
            switch (alt7) {
                case 1 :
                    // InternalMdal.g:275:4: otherlv_15= 'version' ( (lv_version_16_0= RULE_STRING ) )
                    {
                    otherlv_15=(Token)match(input,20,FOLLOW_4); 

                    				newLeafNode(otherlv_15, grammarAccess.getAlExtensionAccess().getVersionKeyword_7_0());
                    			
                    // InternalMdal.g:279:4: ( (lv_version_16_0= RULE_STRING ) )
                    // InternalMdal.g:280:5: (lv_version_16_0= RULE_STRING )
                    {
                    // InternalMdal.g:280:5: (lv_version_16_0= RULE_STRING )
                    // InternalMdal.g:281:6: lv_version_16_0= RULE_STRING
                    {
                    lv_version_16_0=(Token)match(input,RULE_STRING,FOLLOW_14); 

                    						newLeafNode(lv_version_16_0, grammarAccess.getAlExtensionAccess().getVersionSTRINGTerminalRuleCall_7_1_0());
                    					

                    						if (current==null) {
                    							current = createModelElement(grammarAccess.getAlExtensionRule());
                    						}
                    						setWithLastConsumed(
                    							current,
                    							"version",
                    							lv_version_16_0,
                    							"org.eclipse.xtext.common.Terminals.STRING");
                    					

                    }


                    }


                    }
                    break;

            }

            // InternalMdal.g:298:3: (otherlv_17= 'brief' ( (lv_brief_18_0= RULE_STRING ) ) )?
            int alt8=2;
            int LA8_0 = input.LA(1);

            if ( (LA8_0==21) ) {
                alt8=1;
            }
            switch (alt8) {
                case 1 :
                    // InternalMdal.g:299:4: otherlv_17= 'brief' ( (lv_brief_18_0= RULE_STRING ) )
                    {
                    otherlv_17=(Token)match(input,21,FOLLOW_4); 

                    				newLeafNode(otherlv_17, grammarAccess.getAlExtensionAccess().getBriefKeyword_8_0());
                    			
                    // InternalMdal.g:303:4: ( (lv_brief_18_0= RULE_STRING ) )
                    // InternalMdal.g:304:5: (lv_brief_18_0= RULE_STRING )
                    {
                    // InternalMdal.g:304:5: (lv_brief_18_0= RULE_STRING )
                    // InternalMdal.g:305:6: lv_brief_18_0= RULE_STRING
                    {
                    lv_brief_18_0=(Token)match(input,RULE_STRING,FOLLOW_15); 

                    						newLeafNode(lv_brief_18_0, grammarAccess.getAlExtensionAccess().getBriefSTRINGTerminalRuleCall_8_1_0());
                    					

                    						if (current==null) {
                    							current = createModelElement(grammarAccess.getAlExtensionRule());
                    						}
                    						setWithLastConsumed(
                    							current,
                    							"brief",
                    							lv_brief_18_0,
                    							"org.eclipse.xtext.common.Terminals.STRING");
                    					

                    }


                    }


                    }
                    break;

            }

            // InternalMdal.g:322:3: (otherlv_19= 'description' ( (lv_description_20_0= RULE_STRING ) ) )?
            int alt9=2;
            int LA9_0 = input.LA(1);

            if ( (LA9_0==22) ) {
                alt9=1;
            }
            switch (alt9) {
                case 1 :
                    // InternalMdal.g:323:4: otherlv_19= 'description' ( (lv_description_20_0= RULE_STRING ) )
                    {
                    otherlv_19=(Token)match(input,22,FOLLOW_4); 

                    				newLeafNode(otherlv_19, grammarAccess.getAlExtensionAccess().getDescriptionKeyword_9_0());
                    			
                    // InternalMdal.g:327:4: ( (lv_description_20_0= RULE_STRING ) )
                    // InternalMdal.g:328:5: (lv_description_20_0= RULE_STRING )
                    {
                    // InternalMdal.g:328:5: (lv_description_20_0= RULE_STRING )
                    // InternalMdal.g:329:6: lv_description_20_0= RULE_STRING
                    {
                    lv_description_20_0=(Token)match(input,RULE_STRING,FOLLOW_16); 

                    						newLeafNode(lv_description_20_0, grammarAccess.getAlExtensionAccess().getDescriptionSTRINGTerminalRuleCall_9_1_0());
                    					

                    						if (current==null) {
                    							current = createModelElement(grammarAccess.getAlExtensionRule());
                    						}
                    						setWithLastConsumed(
                    							current,
                    							"description",
                    							lv_description_20_0,
                    							"org.eclipse.xtext.common.Terminals.STRING");
                    					

                    }


                    }


                    }
                    break;

            }

            // InternalMdal.g:346:3: (otherlv_21= 'privacyStatement' ( (lv_privacyStatement_22_0= RULE_STRING ) ) )?
            int alt10=2;
            int LA10_0 = input.LA(1);

            if ( (LA10_0==23) ) {
                alt10=1;
            }
            switch (alt10) {
                case 1 :
                    // InternalMdal.g:347:4: otherlv_21= 'privacyStatement' ( (lv_privacyStatement_22_0= RULE_STRING ) )
                    {
                    otherlv_21=(Token)match(input,23,FOLLOW_4); 

                    				newLeafNode(otherlv_21, grammarAccess.getAlExtensionAccess().getPrivacyStatementKeyword_10_0());
                    			
                    // InternalMdal.g:351:4: ( (lv_privacyStatement_22_0= RULE_STRING ) )
                    // InternalMdal.g:352:5: (lv_privacyStatement_22_0= RULE_STRING )
                    {
                    // InternalMdal.g:352:5: (lv_privacyStatement_22_0= RULE_STRING )
                    // InternalMdal.g:353:6: lv_privacyStatement_22_0= RULE_STRING
                    {
                    lv_privacyStatement_22_0=(Token)match(input,RULE_STRING,FOLLOW_17); 

                    						newLeafNode(lv_privacyStatement_22_0, grammarAccess.getAlExtensionAccess().getPrivacyStatementSTRINGTerminalRuleCall_10_1_0());
                    					

                    						if (current==null) {
                    							current = createModelElement(grammarAccess.getAlExtensionRule());
                    						}
                    						setWithLastConsumed(
                    							current,
                    							"privacyStatement",
                    							lv_privacyStatement_22_0,
                    							"org.eclipse.xtext.common.Terminals.STRING");
                    					

                    }


                    }


                    }
                    break;

            }

            // InternalMdal.g:370:3: (otherlv_23= 'eula' ( (lv_eula_24_0= RULE_STRING ) ) )?
            int alt11=2;
            int LA11_0 = input.LA(1);

            if ( (LA11_0==24) ) {
                alt11=1;
            }
            switch (alt11) {
                case 1 :
                    // InternalMdal.g:371:4: otherlv_23= 'eula' ( (lv_eula_24_0= RULE_STRING ) )
                    {
                    otherlv_23=(Token)match(input,24,FOLLOW_4); 

                    				newLeafNode(otherlv_23, grammarAccess.getAlExtensionAccess().getEulaKeyword_11_0());
                    			
                    // InternalMdal.g:375:4: ( (lv_eula_24_0= RULE_STRING ) )
                    // InternalMdal.g:376:5: (lv_eula_24_0= RULE_STRING )
                    {
                    // InternalMdal.g:376:5: (lv_eula_24_0= RULE_STRING )
                    // InternalMdal.g:377:6: lv_eula_24_0= RULE_STRING
                    {
                    lv_eula_24_0=(Token)match(input,RULE_STRING,FOLLOW_18); 

                    						newLeafNode(lv_eula_24_0, grammarAccess.getAlExtensionAccess().getEulaSTRINGTerminalRuleCall_11_1_0());
                    					

                    						if (current==null) {
                    							current = createModelElement(grammarAccess.getAlExtensionRule());
                    						}
                    						setWithLastConsumed(
                    							current,
                    							"eula",
                    							lv_eula_24_0,
                    							"org.eclipse.xtext.common.Terminals.STRING");
                    					

                    }


                    }


                    }
                    break;

            }

            // InternalMdal.g:394:3: (otherlv_25= 'help' ( (lv_help_26_0= RULE_STRING ) ) )?
            int alt12=2;
            int LA12_0 = input.LA(1);

            if ( (LA12_0==25) ) {
                alt12=1;
            }
            switch (alt12) {
                case 1 :
                    // InternalMdal.g:395:4: otherlv_25= 'help' ( (lv_help_26_0= RULE_STRING ) )
                    {
                    otherlv_25=(Token)match(input,25,FOLLOW_4); 

                    				newLeafNode(otherlv_25, grammarAccess.getAlExtensionAccess().getHelpKeyword_12_0());
                    			
                    // InternalMdal.g:399:4: ( (lv_help_26_0= RULE_STRING ) )
                    // InternalMdal.g:400:5: (lv_help_26_0= RULE_STRING )
                    {
                    // InternalMdal.g:400:5: (lv_help_26_0= RULE_STRING )
                    // InternalMdal.g:401:6: lv_help_26_0= RULE_STRING
                    {
                    lv_help_26_0=(Token)match(input,RULE_STRING,FOLLOW_19); 

                    						newLeafNode(lv_help_26_0, grammarAccess.getAlExtensionAccess().getHelpSTRINGTerminalRuleCall_12_1_0());
                    					

                    						if (current==null) {
                    							current = createModelElement(grammarAccess.getAlExtensionRule());
                    						}
                    						setWithLastConsumed(
                    							current,
                    							"help",
                    							lv_help_26_0,
                    							"org.eclipse.xtext.common.Terminals.STRING");
                    					

                    }


                    }


                    }
                    break;

            }

            // InternalMdal.g:418:3: (otherlv_27= 'url' ( (lv_url_28_0= RULE_STRING ) ) )?
            int alt13=2;
            int LA13_0 = input.LA(1);

            if ( (LA13_0==26) ) {
                alt13=1;
            }
            switch (alt13) {
                case 1 :
                    // InternalMdal.g:419:4: otherlv_27= 'url' ( (lv_url_28_0= RULE_STRING ) )
                    {
                    otherlv_27=(Token)match(input,26,FOLLOW_4); 

                    				newLeafNode(otherlv_27, grammarAccess.getAlExtensionAccess().getUrlKeyword_13_0());
                    			
                    // InternalMdal.g:423:4: ( (lv_url_28_0= RULE_STRING ) )
                    // InternalMdal.g:424:5: (lv_url_28_0= RULE_STRING )
                    {
                    // InternalMdal.g:424:5: (lv_url_28_0= RULE_STRING )
                    // InternalMdal.g:425:6: lv_url_28_0= RULE_STRING
                    {
                    lv_url_28_0=(Token)match(input,RULE_STRING,FOLLOW_20); 

                    						newLeafNode(lv_url_28_0, grammarAccess.getAlExtensionAccess().getUrlSTRINGTerminalRuleCall_13_1_0());
                    					

                    						if (current==null) {
                    							current = createModelElement(grammarAccess.getAlExtensionRule());
                    						}
                    						setWithLastConsumed(
                    							current,
                    							"url",
                    							lv_url_28_0,
                    							"org.eclipse.xtext.common.Terminals.STRING");
                    					

                    }


                    }


                    }
                    break;

            }

            // InternalMdal.g:442:3: (otherlv_29= 'contextSensitiveHelpUrl' ( (lv_contextSensitiveHelpUrl_30_0= RULE_STRING ) ) )?
            int alt14=2;
            int LA14_0 = input.LA(1);

            if ( (LA14_0==27) ) {
                alt14=1;
            }
            switch (alt14) {
                case 1 :
                    // InternalMdal.g:443:4: otherlv_29= 'contextSensitiveHelpUrl' ( (lv_contextSensitiveHelpUrl_30_0= RULE_STRING ) )
                    {
                    otherlv_29=(Token)match(input,27,FOLLOW_4); 

                    				newLeafNode(otherlv_29, grammarAccess.getAlExtensionAccess().getContextSensitiveHelpUrlKeyword_14_0());
                    			
                    // InternalMdal.g:447:4: ( (lv_contextSensitiveHelpUrl_30_0= RULE_STRING ) )
                    // InternalMdal.g:448:5: (lv_contextSensitiveHelpUrl_30_0= RULE_STRING )
                    {
                    // InternalMdal.g:448:5: (lv_contextSensitiveHelpUrl_30_0= RULE_STRING )
                    // InternalMdal.g:449:6: lv_contextSensitiveHelpUrl_30_0= RULE_STRING
                    {
                    lv_contextSensitiveHelpUrl_30_0=(Token)match(input,RULE_STRING,FOLLOW_21); 

                    						newLeafNode(lv_contextSensitiveHelpUrl_30_0, grammarAccess.getAlExtensionAccess().getContextSensitiveHelpUrlSTRINGTerminalRuleCall_14_1_0());
                    					

                    						if (current==null) {
                    							current = createModelElement(grammarAccess.getAlExtensionRule());
                    						}
                    						setWithLastConsumed(
                    							current,
                    							"contextSensitiveHelpUrl",
                    							lv_contextSensitiveHelpUrl_30_0,
                    							"org.eclipse.xtext.common.Terminals.STRING");
                    					

                    }


                    }


                    }
                    break;

            }

            // InternalMdal.g:466:3: (otherlv_31= 'showMyCode' ( (lv_showMyCode_32_0= ruleBool ) ) )?
            int alt15=2;
            int LA15_0 = input.LA(1);

            if ( (LA15_0==28) ) {
                alt15=1;
            }
            switch (alt15) {
                case 1 :
                    // InternalMdal.g:467:4: otherlv_31= 'showMyCode' ( (lv_showMyCode_32_0= ruleBool ) )
                    {
                    otherlv_31=(Token)match(input,28,FOLLOW_22); 

                    				newLeafNode(otherlv_31, grammarAccess.getAlExtensionAccess().getShowMyCodeKeyword_15_0());
                    			
                    // InternalMdal.g:471:4: ( (lv_showMyCode_32_0= ruleBool ) )
                    // InternalMdal.g:472:5: (lv_showMyCode_32_0= ruleBool )
                    {
                    // InternalMdal.g:472:5: (lv_showMyCode_32_0= ruleBool )
                    // InternalMdal.g:473:6: lv_showMyCode_32_0= ruleBool
                    {

                    						newCompositeNode(grammarAccess.getAlExtensionAccess().getShowMyCodeBoolEnumRuleCall_15_1_0());
                    					
                    pushFollow(FOLLOW_23);
                    lv_showMyCode_32_0=ruleBool();

                    state._fsp--;


                    						if (current==null) {
                    							current = createModelElementForParent(grammarAccess.getAlExtensionRule());
                    						}
                    						set(
                    							current,
                    							"showMyCode",
                    							lv_showMyCode_32_0,
                    							"de.joneug.mdal.Mdal.Bool");
                    						afterParserOrEnumRuleCall();
                    					

                    }


                    }


                    }
                    break;

            }

            // InternalMdal.g:491:3: (otherlv_33= 'runtime' ( (lv_runtime_34_0= RULE_STRING ) ) )?
            int alt16=2;
            int LA16_0 = input.LA(1);

            if ( (LA16_0==29) ) {
                alt16=1;
            }
            switch (alt16) {
                case 1 :
                    // InternalMdal.g:492:4: otherlv_33= 'runtime' ( (lv_runtime_34_0= RULE_STRING ) )
                    {
                    otherlv_33=(Token)match(input,29,FOLLOW_4); 

                    				newLeafNode(otherlv_33, grammarAccess.getAlExtensionAccess().getRuntimeKeyword_16_0());
                    			
                    // InternalMdal.g:496:4: ( (lv_runtime_34_0= RULE_STRING ) )
                    // InternalMdal.g:497:5: (lv_runtime_34_0= RULE_STRING )
                    {
                    // InternalMdal.g:497:5: (lv_runtime_34_0= RULE_STRING )
                    // InternalMdal.g:498:6: lv_runtime_34_0= RULE_STRING
                    {
                    lv_runtime_34_0=(Token)match(input,RULE_STRING,FOLLOW_24); 

                    						newLeafNode(lv_runtime_34_0, grammarAccess.getAlExtensionAccess().getRuntimeSTRINGTerminalRuleCall_16_1_0());
                    					

                    						if (current==null) {
                    							current = createModelElement(grammarAccess.getAlExtensionRule());
                    						}
                    						setWithLastConsumed(
                    							current,
                    							"runtime",
                    							lv_runtime_34_0,
                    							"org.eclipse.xtext.common.Terminals.STRING");
                    					

                    }


                    }


                    }
                    break;

            }

            otherlv_35=(Token)match(input,30,FOLLOW_2); 

            			newLeafNode(otherlv_35, grammarAccess.getAlExtensionAccess().getRightCurlyBracketKeyword_17());
            		

            }


            }


            	leaveRule();

        }

            catch (RecognitionException re) {
                recover(input,re);
                appendSkippedTokens();
            }
        finally {
        }
        return current;
    }
    // $ANTLR end "ruleAlExtension"


    // $ANTLR start "entryRuleType"
    // InternalMdal.g:523:1: entryRuleType returns [EObject current=null] : iv_ruleType= ruleType EOF ;
    public final EObject entryRuleType() throws RecognitionException {
        EObject current = null;

        EObject iv_ruleType = null;


        try {
            // InternalMdal.g:523:45: (iv_ruleType= ruleType EOF )
            // InternalMdal.g:524:2: iv_ruleType= ruleType EOF
            {
             newCompositeNode(grammarAccess.getTypeRule()); 
            pushFollow(FOLLOW_1);
            iv_ruleType=ruleType();

            state._fsp--;

             current =iv_ruleType; 
            match(input,EOF,FOLLOW_2); 

            }

        }

            catch (RecognitionException re) {
                recover(input,re);
                appendSkippedTokens();
            }
        finally {
        }
        return current;
    }
    // $ANTLR end "entryRuleType"


    // $ANTLR start "ruleType"
    // InternalMdal.g:530:1: ruleType returns [EObject current=null] : this_TypeText_0= ruleTypeText ;
    public final EObject ruleType() throws RecognitionException {
        EObject current = null;

        EObject this_TypeText_0 = null;



        	enterRule();

        try {
            // InternalMdal.g:536:2: (this_TypeText_0= ruleTypeText )
            // InternalMdal.g:537:2: this_TypeText_0= ruleTypeText
            {

            		newCompositeNode(grammarAccess.getTypeAccess().getTypeTextParserRuleCall());
            	
            pushFollow(FOLLOW_2);
            this_TypeText_0=ruleTypeText();

            state._fsp--;


            		current = this_TypeText_0;
            		afterParserOrEnumRuleCall();
            	

            }


            	leaveRule();

        }

            catch (RecognitionException re) {
                recover(input,re);
                appendSkippedTokens();
            }
        finally {
        }
        return current;
    }
    // $ANTLR end "ruleType"


    // $ANTLR start "entryRuleTypeText"
    // InternalMdal.g:548:1: entryRuleTypeText returns [EObject current=null] : iv_ruleTypeText= ruleTypeText EOF ;
    public final EObject entryRuleTypeText() throws RecognitionException {
        EObject current = null;

        EObject iv_ruleTypeText = null;


        try {
            // InternalMdal.g:548:49: (iv_ruleTypeText= ruleTypeText EOF )
            // InternalMdal.g:549:2: iv_ruleTypeText= ruleTypeText EOF
            {
             newCompositeNode(grammarAccess.getTypeTextRule()); 
            pushFollow(FOLLOW_1);
            iv_ruleTypeText=ruleTypeText();

            state._fsp--;

             current =iv_ruleTypeText; 
            match(input,EOF,FOLLOW_2); 

            }

        }

            catch (RecognitionException re) {
                recover(input,re);
                appendSkippedTokens();
            }
        finally {
        }
        return current;
    }
    // $ANTLR end "entryRuleTypeText"


    // $ANTLR start "ruleTypeText"
    // InternalMdal.g:555:1: ruleTypeText returns [EObject current=null] : ( () otherlv_1= 'Text' (otherlv_2= '[' ( (lv_length_3_0= RULE_INT ) ) otherlv_4= ']' )? ) ;
    public final EObject ruleTypeText() throws RecognitionException {
        EObject current = null;

        Token otherlv_1=null;
        Token otherlv_2=null;
        Token lv_length_3_0=null;
        Token otherlv_4=null;


        	enterRule();

        try {
            // InternalMdal.g:561:2: ( ( () otherlv_1= 'Text' (otherlv_2= '[' ( (lv_length_3_0= RULE_INT ) ) otherlv_4= ']' )? ) )
            // InternalMdal.g:562:2: ( () otherlv_1= 'Text' (otherlv_2= '[' ( (lv_length_3_0= RULE_INT ) ) otherlv_4= ']' )? )
            {
            // InternalMdal.g:562:2: ( () otherlv_1= 'Text' (otherlv_2= '[' ( (lv_length_3_0= RULE_INT ) ) otherlv_4= ']' )? )
            // InternalMdal.g:563:3: () otherlv_1= 'Text' (otherlv_2= '[' ( (lv_length_3_0= RULE_INT ) ) otherlv_4= ']' )?
            {
            // InternalMdal.g:563:3: ()
            // InternalMdal.g:564:4: 
            {

            				current = forceCreateModelElement(
            					grammarAccess.getTypeTextAccess().getTypeTextAction_0(),
            					current);
            			

            }

            otherlv_1=(Token)match(input,31,FOLLOW_25); 

            			newLeafNode(otherlv_1, grammarAccess.getTypeTextAccess().getTextKeyword_1());
            		
            // InternalMdal.g:574:3: (otherlv_2= '[' ( (lv_length_3_0= RULE_INT ) ) otherlv_4= ']' )?
            int alt17=2;
            int LA17_0 = input.LA(1);

            if ( (LA17_0==15) ) {
                alt17=1;
            }
            switch (alt17) {
                case 1 :
                    // InternalMdal.g:575:4: otherlv_2= '[' ( (lv_length_3_0= RULE_INT ) ) otherlv_4= ']'
                    {
                    otherlv_2=(Token)match(input,15,FOLLOW_9); 

                    				newLeafNode(otherlv_2, grammarAccess.getTypeTextAccess().getLeftSquareBracketKeyword_2_0());
                    			
                    // InternalMdal.g:579:4: ( (lv_length_3_0= RULE_INT ) )
                    // InternalMdal.g:580:5: (lv_length_3_0= RULE_INT )
                    {
                    // InternalMdal.g:580:5: (lv_length_3_0= RULE_INT )
                    // InternalMdal.g:581:6: lv_length_3_0= RULE_INT
                    {
                    lv_length_3_0=(Token)match(input,RULE_INT,FOLLOW_26); 

                    						newLeafNode(lv_length_3_0, grammarAccess.getTypeTextAccess().getLengthINTTerminalRuleCall_2_1_0());
                    					

                    						if (current==null) {
                    							current = createModelElement(grammarAccess.getTypeTextRule());
                    						}
                    						setWithLastConsumed(
                    							current,
                    							"length",
                    							lv_length_3_0,
                    							"org.eclipse.xtext.common.Terminals.INT");
                    					

                    }


                    }

                    otherlv_4=(Token)match(input,17,FOLLOW_2); 

                    				newLeafNode(otherlv_4, grammarAccess.getTypeTextAccess().getRightSquareBracketKeyword_2_2());
                    			

                    }
                    break;

            }


            }


            }


            	leaveRule();

        }

            catch (RecognitionException re) {
                recover(input,re);
                appendSkippedTokens();
            }
        finally {
        }
        return current;
    }
    // $ANTLR end "ruleTypeText"


    // $ANTLR start "entryRuleIdRange"
    // InternalMdal.g:606:1: entryRuleIdRange returns [EObject current=null] : iv_ruleIdRange= ruleIdRange EOF ;
    public final EObject entryRuleIdRange() throws RecognitionException {
        EObject current = null;

        EObject iv_ruleIdRange = null;


        try {
            // InternalMdal.g:606:48: (iv_ruleIdRange= ruleIdRange EOF )
            // InternalMdal.g:607:2: iv_ruleIdRange= ruleIdRange EOF
            {
             newCompositeNode(grammarAccess.getIdRangeRule()); 
            pushFollow(FOLLOW_1);
            iv_ruleIdRange=ruleIdRange();

            state._fsp--;

             current =iv_ruleIdRange; 
            match(input,EOF,FOLLOW_2); 

            }

        }

            catch (RecognitionException re) {
                recover(input,re);
                appendSkippedTokens();
            }
        finally {
        }
        return current;
    }
    // $ANTLR end "entryRuleIdRange"


    // $ANTLR start "ruleIdRange"
    // InternalMdal.g:613:1: ruleIdRange returns [EObject current=null] : ( ( (lv_min_0_0= RULE_INT ) ) (otherlv_1= '..' ( (lv_max_2_0= RULE_INT ) ) )? ) ;
    public final EObject ruleIdRange() throws RecognitionException {
        EObject current = null;

        Token lv_min_0_0=null;
        Token otherlv_1=null;
        Token lv_max_2_0=null;


        	enterRule();

        try {
            // InternalMdal.g:619:2: ( ( ( (lv_min_0_0= RULE_INT ) ) (otherlv_1= '..' ( (lv_max_2_0= RULE_INT ) ) )? ) )
            // InternalMdal.g:620:2: ( ( (lv_min_0_0= RULE_INT ) ) (otherlv_1= '..' ( (lv_max_2_0= RULE_INT ) ) )? )
            {
            // InternalMdal.g:620:2: ( ( (lv_min_0_0= RULE_INT ) ) (otherlv_1= '..' ( (lv_max_2_0= RULE_INT ) ) )? )
            // InternalMdal.g:621:3: ( (lv_min_0_0= RULE_INT ) ) (otherlv_1= '..' ( (lv_max_2_0= RULE_INT ) ) )?
            {
            // InternalMdal.g:621:3: ( (lv_min_0_0= RULE_INT ) )
            // InternalMdal.g:622:4: (lv_min_0_0= RULE_INT )
            {
            // InternalMdal.g:622:4: (lv_min_0_0= RULE_INT )
            // InternalMdal.g:623:5: lv_min_0_0= RULE_INT
            {
            lv_min_0_0=(Token)match(input,RULE_INT,FOLLOW_27); 

            					newLeafNode(lv_min_0_0, grammarAccess.getIdRangeAccess().getMinINTTerminalRuleCall_0_0());
            				

            					if (current==null) {
            						current = createModelElement(grammarAccess.getIdRangeRule());
            					}
            					setWithLastConsumed(
            						current,
            						"min",
            						lv_min_0_0,
            						"org.eclipse.xtext.common.Terminals.INT");
            				

            }


            }

            // InternalMdal.g:639:3: (otherlv_1= '..' ( (lv_max_2_0= RULE_INT ) ) )?
            int alt18=2;
            int LA18_0 = input.LA(1);

            if ( (LA18_0==32) ) {
                alt18=1;
            }
            switch (alt18) {
                case 1 :
                    // InternalMdal.g:640:4: otherlv_1= '..' ( (lv_max_2_0= RULE_INT ) )
                    {
                    otherlv_1=(Token)match(input,32,FOLLOW_9); 

                    				newLeafNode(otherlv_1, grammarAccess.getIdRangeAccess().getFullStopFullStopKeyword_1_0());
                    			
                    // InternalMdal.g:644:4: ( (lv_max_2_0= RULE_INT ) )
                    // InternalMdal.g:645:5: (lv_max_2_0= RULE_INT )
                    {
                    // InternalMdal.g:645:5: (lv_max_2_0= RULE_INT )
                    // InternalMdal.g:646:6: lv_max_2_0= RULE_INT
                    {
                    lv_max_2_0=(Token)match(input,RULE_INT,FOLLOW_2); 

                    						newLeafNode(lv_max_2_0, grammarAccess.getIdRangeAccess().getMaxINTTerminalRuleCall_1_1_0());
                    					

                    						if (current==null) {
                    							current = createModelElement(grammarAccess.getIdRangeRule());
                    						}
                    						setWithLastConsumed(
                    							current,
                    							"max",
                    							lv_max_2_0,
                    							"org.eclipse.xtext.common.Terminals.INT");
                    					

                    }


                    }


                    }
                    break;

            }


            }


            }


            	leaveRule();

        }

            catch (RecognitionException re) {
                recover(input,re);
                appendSkippedTokens();
            }
        finally {
        }
        return current;
    }
    // $ANTLR end "ruleIdRange"


    // $ANTLR start "ruleBool"
    // InternalMdal.g:667:1: ruleBool returns [Enumerator current=null] : ( (enumLiteral_0= 'true' ) | (enumLiteral_1= 'false' ) ) ;
    public final Enumerator ruleBool() throws RecognitionException {
        Enumerator current = null;

        Token enumLiteral_0=null;
        Token enumLiteral_1=null;


        	enterRule();

        try {
            // InternalMdal.g:673:2: ( ( (enumLiteral_0= 'true' ) | (enumLiteral_1= 'false' ) ) )
            // InternalMdal.g:674:2: ( (enumLiteral_0= 'true' ) | (enumLiteral_1= 'false' ) )
            {
            // InternalMdal.g:674:2: ( (enumLiteral_0= 'true' ) | (enumLiteral_1= 'false' ) )
            int alt19=2;
            int LA19_0 = input.LA(1);

            if ( (LA19_0==33) ) {
                alt19=1;
            }
            else if ( (LA19_0==34) ) {
                alt19=2;
            }
            else {
                NoViableAltException nvae =
                    new NoViableAltException("", 19, 0, input);

                throw nvae;
            }
            switch (alt19) {
                case 1 :
                    // InternalMdal.g:675:3: (enumLiteral_0= 'true' )
                    {
                    // InternalMdal.g:675:3: (enumLiteral_0= 'true' )
                    // InternalMdal.g:676:4: enumLiteral_0= 'true'
                    {
                    enumLiteral_0=(Token)match(input,33,FOLLOW_2); 

                    				current = grammarAccess.getBoolAccess().getTRUEEnumLiteralDeclaration_0().getEnumLiteral().getInstance();
                    				newLeafNode(enumLiteral_0, grammarAccess.getBoolAccess().getTRUEEnumLiteralDeclaration_0());
                    			

                    }


                    }
                    break;
                case 2 :
                    // InternalMdal.g:683:3: (enumLiteral_1= 'false' )
                    {
                    // InternalMdal.g:683:3: (enumLiteral_1= 'false' )
                    // InternalMdal.g:684:4: enumLiteral_1= 'false'
                    {
                    enumLiteral_1=(Token)match(input,34,FOLLOW_2); 

                    				current = grammarAccess.getBoolAccess().getFALSEEnumLiteralDeclaration_1().getEnumLiteral().getInstance();
                    				newLeafNode(enumLiteral_1, grammarAccess.getBoolAccess().getFALSEEnumLiteralDeclaration_1());
                    			

                    }


                    }
                    break;

            }


            }


            	leaveRule();

        }

            catch (RecognitionException re) {
                recover(input,re);
                appendSkippedTokens();
            }
        finally {
        }
        return current;
    }
    // $ANTLR end "ruleBool"

    // Delegated rules


 

    public static final BitSet FOLLOW_1 = new BitSet(new long[]{0x0000000000000000L});
    public static final BitSet FOLLOW_2 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_3 = new BitSet(new long[]{0x0000000000000802L});
    public static final BitSet FOLLOW_4 = new BitSet(new long[]{0x0000000000000010L});
    public static final BitSet FOLLOW_5 = new BitSet(new long[]{0x0000000000001000L});
    public static final BitSet FOLLOW_6 = new BitSet(new long[]{0x000000007FFC6000L});
    public static final BitSet FOLLOW_7 = new BitSet(new long[]{0x000000007FFC4000L});
    public static final BitSet FOLLOW_8 = new BitSet(new long[]{0x0000000000008000L});
    public static final BitSet FOLLOW_9 = new BitSet(new long[]{0x0000000000000020L});
    public static final BitSet FOLLOW_10 = new BitSet(new long[]{0x0000000000030000L});
    public static final BitSet FOLLOW_11 = new BitSet(new long[]{0x000000007FFC0000L});
    public static final BitSet FOLLOW_12 = new BitSet(new long[]{0x000000007FF80000L});
    public static final BitSet FOLLOW_13 = new BitSet(new long[]{0x000000007FF00000L});
    public static final BitSet FOLLOW_14 = new BitSet(new long[]{0x000000007FE00000L});
    public static final BitSet FOLLOW_15 = new BitSet(new long[]{0x000000007FC00000L});
    public static final BitSet FOLLOW_16 = new BitSet(new long[]{0x000000007F800000L});
    public static final BitSet FOLLOW_17 = new BitSet(new long[]{0x000000007F000000L});
    public static final BitSet FOLLOW_18 = new BitSet(new long[]{0x000000007E000000L});
    public static final BitSet FOLLOW_19 = new BitSet(new long[]{0x000000007C000000L});
    public static final BitSet FOLLOW_20 = new BitSet(new long[]{0x0000000078000000L});
    public static final BitSet FOLLOW_21 = new BitSet(new long[]{0x0000000070000000L});
    public static final BitSet FOLLOW_22 = new BitSet(new long[]{0x0000000600000000L});
    public static final BitSet FOLLOW_23 = new BitSet(new long[]{0x0000000060000000L});
    public static final BitSet FOLLOW_24 = new BitSet(new long[]{0x0000000040000000L});
    public static final BitSet FOLLOW_25 = new BitSet(new long[]{0x0000000000008002L});
    public static final BitSet FOLLOW_26 = new BitSet(new long[]{0x0000000000020000L});
    public static final BitSet FOLLOW_27 = new BitSet(new long[]{0x0000000100000002L});

}