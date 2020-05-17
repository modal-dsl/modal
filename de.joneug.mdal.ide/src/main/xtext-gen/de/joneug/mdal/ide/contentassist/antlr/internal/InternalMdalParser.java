package de.joneug.mdal.ide.contentassist.antlr.internal;

import java.io.InputStream;
import org.eclipse.xtext.*;
import org.eclipse.xtext.parser.*;
import org.eclipse.xtext.parser.impl.*;
import org.eclipse.emf.ecore.util.EcoreUtil;
import org.eclipse.emf.ecore.EObject;
import org.eclipse.xtext.parser.antlr.XtextTokenStream;
import org.eclipse.xtext.parser.antlr.XtextTokenStream.HiddenTokens;
import org.eclipse.xtext.ide.editor.contentassist.antlr.internal.AbstractInternalContentAssistParser;
import org.eclipse.xtext.ide.editor.contentassist.antlr.internal.DFA;
import de.joneug.mdal.services.MdalGrammarAccess;



import org.antlr.runtime.*;
import java.util.Stack;
import java.util.List;
import java.util.ArrayList;

@SuppressWarnings("all")
public class InternalMdalParser extends AbstractInternalContentAssistParser {
    public static final String[] tokenNames = new String[] {
        "<invalid>", "<EOR>", "<DOWN>", "<UP>", "RULE_STRING", "RULE_INT", "RULE_ID", "RULE_ML_COMMENT", "RULE_SL_COMMENT", "RULE_WS", "RULE_ANY_OTHER", "'true'", "'false'", "'extension'", "'{'", "'}'", "'id'", "'idRanges'", "'['", "']'", "','", "'platform'", "'publisher'", "'version'", "'brief'", "'description'", "'privacyStatement'", "'eula'", "'help'", "'url'", "'contextSensitiveHelpUrl'", "'showMyCode'", "'runtime'", "'Text'", "'..'"
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

    	public void setGrammarAccess(MdalGrammarAccess grammarAccess) {
    		this.grammarAccess = grammarAccess;
    	}

    	@Override
    	protected Grammar getGrammar() {
    		return grammarAccess.getGrammar();
    	}

    	@Override
    	protected String getValueForTokenName(String tokenName) {
    		return tokenName;
    	}



    // $ANTLR start "entryRuleModel"
    // InternalMdal.g:53:1: entryRuleModel : ruleModel EOF ;
    public final void entryRuleModel() throws RecognitionException {
        try {
            // InternalMdal.g:54:1: ( ruleModel EOF )
            // InternalMdal.g:55:1: ruleModel EOF
            {
             before(grammarAccess.getModelRule()); 
            pushFollow(FOLLOW_1);
            ruleModel();

            state._fsp--;

             after(grammarAccess.getModelRule()); 
            match(input,EOF,FOLLOW_2); 

            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {
        }
        return ;
    }
    // $ANTLR end "entryRuleModel"


    // $ANTLR start "ruleModel"
    // InternalMdal.g:62:1: ruleModel : ( ( rule__Model__AlExtensionsAssignment )* ) ;
    public final void ruleModel() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:66:2: ( ( ( rule__Model__AlExtensionsAssignment )* ) )
            // InternalMdal.g:67:2: ( ( rule__Model__AlExtensionsAssignment )* )
            {
            // InternalMdal.g:67:2: ( ( rule__Model__AlExtensionsAssignment )* )
            // InternalMdal.g:68:3: ( rule__Model__AlExtensionsAssignment )*
            {
             before(grammarAccess.getModelAccess().getAlExtensionsAssignment()); 
            // InternalMdal.g:69:3: ( rule__Model__AlExtensionsAssignment )*
            loop1:
            do {
                int alt1=2;
                int LA1_0 = input.LA(1);

                if ( (LA1_0==13) ) {
                    alt1=1;
                }


                switch (alt1) {
            	case 1 :
            	    // InternalMdal.g:69:4: rule__Model__AlExtensionsAssignment
            	    {
            	    pushFollow(FOLLOW_3);
            	    rule__Model__AlExtensionsAssignment();

            	    state._fsp--;


            	    }
            	    break;

            	default :
            	    break loop1;
                }
            } while (true);

             after(grammarAccess.getModelAccess().getAlExtensionsAssignment()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "ruleModel"


    // $ANTLR start "entryRuleAlExtension"
    // InternalMdal.g:78:1: entryRuleAlExtension : ruleAlExtension EOF ;
    public final void entryRuleAlExtension() throws RecognitionException {
        try {
            // InternalMdal.g:79:1: ( ruleAlExtension EOF )
            // InternalMdal.g:80:1: ruleAlExtension EOF
            {
             before(grammarAccess.getAlExtensionRule()); 
            pushFollow(FOLLOW_1);
            ruleAlExtension();

            state._fsp--;

             after(grammarAccess.getAlExtensionRule()); 
            match(input,EOF,FOLLOW_2); 

            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {
        }
        return ;
    }
    // $ANTLR end "entryRuleAlExtension"


    // $ANTLR start "ruleAlExtension"
    // InternalMdal.g:87:1: ruleAlExtension : ( ( rule__AlExtension__Group__0 ) ) ;
    public final void ruleAlExtension() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:91:2: ( ( ( rule__AlExtension__Group__0 ) ) )
            // InternalMdal.g:92:2: ( ( rule__AlExtension__Group__0 ) )
            {
            // InternalMdal.g:92:2: ( ( rule__AlExtension__Group__0 ) )
            // InternalMdal.g:93:3: ( rule__AlExtension__Group__0 )
            {
             before(grammarAccess.getAlExtensionAccess().getGroup()); 
            // InternalMdal.g:94:3: ( rule__AlExtension__Group__0 )
            // InternalMdal.g:94:4: rule__AlExtension__Group__0
            {
            pushFollow(FOLLOW_2);
            rule__AlExtension__Group__0();

            state._fsp--;


            }

             after(grammarAccess.getAlExtensionAccess().getGroup()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "ruleAlExtension"


    // $ANTLR start "entryRuleType"
    // InternalMdal.g:103:1: entryRuleType : ruleType EOF ;
    public final void entryRuleType() throws RecognitionException {
        try {
            // InternalMdal.g:104:1: ( ruleType EOF )
            // InternalMdal.g:105:1: ruleType EOF
            {
             before(grammarAccess.getTypeRule()); 
            pushFollow(FOLLOW_1);
            ruleType();

            state._fsp--;

             after(grammarAccess.getTypeRule()); 
            match(input,EOF,FOLLOW_2); 

            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {
        }
        return ;
    }
    // $ANTLR end "entryRuleType"


    // $ANTLR start "ruleType"
    // InternalMdal.g:112:1: ruleType : ( ruleTypeText ) ;
    public final void ruleType() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:116:2: ( ( ruleTypeText ) )
            // InternalMdal.g:117:2: ( ruleTypeText )
            {
            // InternalMdal.g:117:2: ( ruleTypeText )
            // InternalMdal.g:118:3: ruleTypeText
            {
             before(grammarAccess.getTypeAccess().getTypeTextParserRuleCall()); 
            pushFollow(FOLLOW_2);
            ruleTypeText();

            state._fsp--;

             after(grammarAccess.getTypeAccess().getTypeTextParserRuleCall()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "ruleType"


    // $ANTLR start "entryRuleTypeText"
    // InternalMdal.g:128:1: entryRuleTypeText : ruleTypeText EOF ;
    public final void entryRuleTypeText() throws RecognitionException {
        try {
            // InternalMdal.g:129:1: ( ruleTypeText EOF )
            // InternalMdal.g:130:1: ruleTypeText EOF
            {
             before(grammarAccess.getTypeTextRule()); 
            pushFollow(FOLLOW_1);
            ruleTypeText();

            state._fsp--;

             after(grammarAccess.getTypeTextRule()); 
            match(input,EOF,FOLLOW_2); 

            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {
        }
        return ;
    }
    // $ANTLR end "entryRuleTypeText"


    // $ANTLR start "ruleTypeText"
    // InternalMdal.g:137:1: ruleTypeText : ( ( rule__TypeText__Group__0 ) ) ;
    public final void ruleTypeText() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:141:2: ( ( ( rule__TypeText__Group__0 ) ) )
            // InternalMdal.g:142:2: ( ( rule__TypeText__Group__0 ) )
            {
            // InternalMdal.g:142:2: ( ( rule__TypeText__Group__0 ) )
            // InternalMdal.g:143:3: ( rule__TypeText__Group__0 )
            {
             before(grammarAccess.getTypeTextAccess().getGroup()); 
            // InternalMdal.g:144:3: ( rule__TypeText__Group__0 )
            // InternalMdal.g:144:4: rule__TypeText__Group__0
            {
            pushFollow(FOLLOW_2);
            rule__TypeText__Group__0();

            state._fsp--;


            }

             after(grammarAccess.getTypeTextAccess().getGroup()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "ruleTypeText"


    // $ANTLR start "entryRuleIdRange"
    // InternalMdal.g:153:1: entryRuleIdRange : ruleIdRange EOF ;
    public final void entryRuleIdRange() throws RecognitionException {
        try {
            // InternalMdal.g:154:1: ( ruleIdRange EOF )
            // InternalMdal.g:155:1: ruleIdRange EOF
            {
             before(grammarAccess.getIdRangeRule()); 
            pushFollow(FOLLOW_1);
            ruleIdRange();

            state._fsp--;

             after(grammarAccess.getIdRangeRule()); 
            match(input,EOF,FOLLOW_2); 

            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {
        }
        return ;
    }
    // $ANTLR end "entryRuleIdRange"


    // $ANTLR start "ruleIdRange"
    // InternalMdal.g:162:1: ruleIdRange : ( ( rule__IdRange__Group__0 ) ) ;
    public final void ruleIdRange() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:166:2: ( ( ( rule__IdRange__Group__0 ) ) )
            // InternalMdal.g:167:2: ( ( rule__IdRange__Group__0 ) )
            {
            // InternalMdal.g:167:2: ( ( rule__IdRange__Group__0 ) )
            // InternalMdal.g:168:3: ( rule__IdRange__Group__0 )
            {
             before(grammarAccess.getIdRangeAccess().getGroup()); 
            // InternalMdal.g:169:3: ( rule__IdRange__Group__0 )
            // InternalMdal.g:169:4: rule__IdRange__Group__0
            {
            pushFollow(FOLLOW_2);
            rule__IdRange__Group__0();

            state._fsp--;


            }

             after(grammarAccess.getIdRangeAccess().getGroup()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "ruleIdRange"


    // $ANTLR start "ruleBool"
    // InternalMdal.g:178:1: ruleBool : ( ( rule__Bool__Alternatives ) ) ;
    public final void ruleBool() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:182:1: ( ( ( rule__Bool__Alternatives ) ) )
            // InternalMdal.g:183:2: ( ( rule__Bool__Alternatives ) )
            {
            // InternalMdal.g:183:2: ( ( rule__Bool__Alternatives ) )
            // InternalMdal.g:184:3: ( rule__Bool__Alternatives )
            {
             before(grammarAccess.getBoolAccess().getAlternatives()); 
            // InternalMdal.g:185:3: ( rule__Bool__Alternatives )
            // InternalMdal.g:185:4: rule__Bool__Alternatives
            {
            pushFollow(FOLLOW_2);
            rule__Bool__Alternatives();

            state._fsp--;


            }

             after(grammarAccess.getBoolAccess().getAlternatives()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "ruleBool"


    // $ANTLR start "rule__Bool__Alternatives"
    // InternalMdal.g:193:1: rule__Bool__Alternatives : ( ( ( 'true' ) ) | ( ( 'false' ) ) );
    public final void rule__Bool__Alternatives() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:197:1: ( ( ( 'true' ) ) | ( ( 'false' ) ) )
            int alt2=2;
            int LA2_0 = input.LA(1);

            if ( (LA2_0==11) ) {
                alt2=1;
            }
            else if ( (LA2_0==12) ) {
                alt2=2;
            }
            else {
                NoViableAltException nvae =
                    new NoViableAltException("", 2, 0, input);

                throw nvae;
            }
            switch (alt2) {
                case 1 :
                    // InternalMdal.g:198:2: ( ( 'true' ) )
                    {
                    // InternalMdal.g:198:2: ( ( 'true' ) )
                    // InternalMdal.g:199:3: ( 'true' )
                    {
                     before(grammarAccess.getBoolAccess().getTRUEEnumLiteralDeclaration_0()); 
                    // InternalMdal.g:200:3: ( 'true' )
                    // InternalMdal.g:200:4: 'true'
                    {
                    match(input,11,FOLLOW_2); 

                    }

                     after(grammarAccess.getBoolAccess().getTRUEEnumLiteralDeclaration_0()); 

                    }


                    }
                    break;
                case 2 :
                    // InternalMdal.g:204:2: ( ( 'false' ) )
                    {
                    // InternalMdal.g:204:2: ( ( 'false' ) )
                    // InternalMdal.g:205:3: ( 'false' )
                    {
                     before(grammarAccess.getBoolAccess().getFALSEEnumLiteralDeclaration_1()); 
                    // InternalMdal.g:206:3: ( 'false' )
                    // InternalMdal.g:206:4: 'false'
                    {
                    match(input,12,FOLLOW_2); 

                    }

                     after(grammarAccess.getBoolAccess().getFALSEEnumLiteralDeclaration_1()); 

                    }


                    }
                    break;

            }
        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__Bool__Alternatives"


    // $ANTLR start "rule__AlExtension__Group__0"
    // InternalMdal.g:214:1: rule__AlExtension__Group__0 : rule__AlExtension__Group__0__Impl rule__AlExtension__Group__1 ;
    public final void rule__AlExtension__Group__0() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:218:1: ( rule__AlExtension__Group__0__Impl rule__AlExtension__Group__1 )
            // InternalMdal.g:219:2: rule__AlExtension__Group__0__Impl rule__AlExtension__Group__1
            {
            pushFollow(FOLLOW_4);
            rule__AlExtension__Group__0__Impl();

            state._fsp--;

            pushFollow(FOLLOW_2);
            rule__AlExtension__Group__1();

            state._fsp--;


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__Group__0"


    // $ANTLR start "rule__AlExtension__Group__0__Impl"
    // InternalMdal.g:226:1: rule__AlExtension__Group__0__Impl : ( 'extension' ) ;
    public final void rule__AlExtension__Group__0__Impl() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:230:1: ( ( 'extension' ) )
            // InternalMdal.g:231:1: ( 'extension' )
            {
            // InternalMdal.g:231:1: ( 'extension' )
            // InternalMdal.g:232:2: 'extension'
            {
             before(grammarAccess.getAlExtensionAccess().getExtensionKeyword_0()); 
            match(input,13,FOLLOW_2); 
             after(grammarAccess.getAlExtensionAccess().getExtensionKeyword_0()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__Group__0__Impl"


    // $ANTLR start "rule__AlExtension__Group__1"
    // InternalMdal.g:241:1: rule__AlExtension__Group__1 : rule__AlExtension__Group__1__Impl rule__AlExtension__Group__2 ;
    public final void rule__AlExtension__Group__1() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:245:1: ( rule__AlExtension__Group__1__Impl rule__AlExtension__Group__2 )
            // InternalMdal.g:246:2: rule__AlExtension__Group__1__Impl rule__AlExtension__Group__2
            {
            pushFollow(FOLLOW_5);
            rule__AlExtension__Group__1__Impl();

            state._fsp--;

            pushFollow(FOLLOW_2);
            rule__AlExtension__Group__2();

            state._fsp--;


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__Group__1"


    // $ANTLR start "rule__AlExtension__Group__1__Impl"
    // InternalMdal.g:253:1: rule__AlExtension__Group__1__Impl : ( ( rule__AlExtension__NameAssignment_1 ) ) ;
    public final void rule__AlExtension__Group__1__Impl() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:257:1: ( ( ( rule__AlExtension__NameAssignment_1 ) ) )
            // InternalMdal.g:258:1: ( ( rule__AlExtension__NameAssignment_1 ) )
            {
            // InternalMdal.g:258:1: ( ( rule__AlExtension__NameAssignment_1 ) )
            // InternalMdal.g:259:2: ( rule__AlExtension__NameAssignment_1 )
            {
             before(grammarAccess.getAlExtensionAccess().getNameAssignment_1()); 
            // InternalMdal.g:260:2: ( rule__AlExtension__NameAssignment_1 )
            // InternalMdal.g:260:3: rule__AlExtension__NameAssignment_1
            {
            pushFollow(FOLLOW_2);
            rule__AlExtension__NameAssignment_1();

            state._fsp--;


            }

             after(grammarAccess.getAlExtensionAccess().getNameAssignment_1()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__Group__1__Impl"


    // $ANTLR start "rule__AlExtension__Group__2"
    // InternalMdal.g:268:1: rule__AlExtension__Group__2 : rule__AlExtension__Group__2__Impl rule__AlExtension__Group__3 ;
    public final void rule__AlExtension__Group__2() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:272:1: ( rule__AlExtension__Group__2__Impl rule__AlExtension__Group__3 )
            // InternalMdal.g:273:2: rule__AlExtension__Group__2__Impl rule__AlExtension__Group__3
            {
            pushFollow(FOLLOW_6);
            rule__AlExtension__Group__2__Impl();

            state._fsp--;

            pushFollow(FOLLOW_2);
            rule__AlExtension__Group__3();

            state._fsp--;


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__Group__2"


    // $ANTLR start "rule__AlExtension__Group__2__Impl"
    // InternalMdal.g:280:1: rule__AlExtension__Group__2__Impl : ( '{' ) ;
    public final void rule__AlExtension__Group__2__Impl() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:284:1: ( ( '{' ) )
            // InternalMdal.g:285:1: ( '{' )
            {
            // InternalMdal.g:285:1: ( '{' )
            // InternalMdal.g:286:2: '{'
            {
             before(grammarAccess.getAlExtensionAccess().getLeftCurlyBracketKeyword_2()); 
            match(input,14,FOLLOW_2); 
             after(grammarAccess.getAlExtensionAccess().getLeftCurlyBracketKeyword_2()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__Group__2__Impl"


    // $ANTLR start "rule__AlExtension__Group__3"
    // InternalMdal.g:295:1: rule__AlExtension__Group__3 : rule__AlExtension__Group__3__Impl rule__AlExtension__Group__4 ;
    public final void rule__AlExtension__Group__3() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:299:1: ( rule__AlExtension__Group__3__Impl rule__AlExtension__Group__4 )
            // InternalMdal.g:300:2: rule__AlExtension__Group__3__Impl rule__AlExtension__Group__4
            {
            pushFollow(FOLLOW_6);
            rule__AlExtension__Group__3__Impl();

            state._fsp--;

            pushFollow(FOLLOW_2);
            rule__AlExtension__Group__4();

            state._fsp--;


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__Group__3"


    // $ANTLR start "rule__AlExtension__Group__3__Impl"
    // InternalMdal.g:307:1: rule__AlExtension__Group__3__Impl : ( ( rule__AlExtension__Group_3__0 )? ) ;
    public final void rule__AlExtension__Group__3__Impl() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:311:1: ( ( ( rule__AlExtension__Group_3__0 )? ) )
            // InternalMdal.g:312:1: ( ( rule__AlExtension__Group_3__0 )? )
            {
            // InternalMdal.g:312:1: ( ( rule__AlExtension__Group_3__0 )? )
            // InternalMdal.g:313:2: ( rule__AlExtension__Group_3__0 )?
            {
             before(grammarAccess.getAlExtensionAccess().getGroup_3()); 
            // InternalMdal.g:314:2: ( rule__AlExtension__Group_3__0 )?
            int alt3=2;
            int LA3_0 = input.LA(1);

            if ( (LA3_0==16) ) {
                alt3=1;
            }
            switch (alt3) {
                case 1 :
                    // InternalMdal.g:314:3: rule__AlExtension__Group_3__0
                    {
                    pushFollow(FOLLOW_2);
                    rule__AlExtension__Group_3__0();

                    state._fsp--;


                    }
                    break;

            }

             after(grammarAccess.getAlExtensionAccess().getGroup_3()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__Group__3__Impl"


    // $ANTLR start "rule__AlExtension__Group__4"
    // InternalMdal.g:322:1: rule__AlExtension__Group__4 : rule__AlExtension__Group__4__Impl rule__AlExtension__Group__5 ;
    public final void rule__AlExtension__Group__4() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:326:1: ( rule__AlExtension__Group__4__Impl rule__AlExtension__Group__5 )
            // InternalMdal.g:327:2: rule__AlExtension__Group__4__Impl rule__AlExtension__Group__5
            {
            pushFollow(FOLLOW_6);
            rule__AlExtension__Group__4__Impl();

            state._fsp--;

            pushFollow(FOLLOW_2);
            rule__AlExtension__Group__5();

            state._fsp--;


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__Group__4"


    // $ANTLR start "rule__AlExtension__Group__4__Impl"
    // InternalMdal.g:334:1: rule__AlExtension__Group__4__Impl : ( ( rule__AlExtension__Group_4__0 )? ) ;
    public final void rule__AlExtension__Group__4__Impl() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:338:1: ( ( ( rule__AlExtension__Group_4__0 )? ) )
            // InternalMdal.g:339:1: ( ( rule__AlExtension__Group_4__0 )? )
            {
            // InternalMdal.g:339:1: ( ( rule__AlExtension__Group_4__0 )? )
            // InternalMdal.g:340:2: ( rule__AlExtension__Group_4__0 )?
            {
             before(grammarAccess.getAlExtensionAccess().getGroup_4()); 
            // InternalMdal.g:341:2: ( rule__AlExtension__Group_4__0 )?
            int alt4=2;
            int LA4_0 = input.LA(1);

            if ( (LA4_0==17) ) {
                alt4=1;
            }
            switch (alt4) {
                case 1 :
                    // InternalMdal.g:341:3: rule__AlExtension__Group_4__0
                    {
                    pushFollow(FOLLOW_2);
                    rule__AlExtension__Group_4__0();

                    state._fsp--;


                    }
                    break;

            }

             after(grammarAccess.getAlExtensionAccess().getGroup_4()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__Group__4__Impl"


    // $ANTLR start "rule__AlExtension__Group__5"
    // InternalMdal.g:349:1: rule__AlExtension__Group__5 : rule__AlExtension__Group__5__Impl rule__AlExtension__Group__6 ;
    public final void rule__AlExtension__Group__5() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:353:1: ( rule__AlExtension__Group__5__Impl rule__AlExtension__Group__6 )
            // InternalMdal.g:354:2: rule__AlExtension__Group__5__Impl rule__AlExtension__Group__6
            {
            pushFollow(FOLLOW_6);
            rule__AlExtension__Group__5__Impl();

            state._fsp--;

            pushFollow(FOLLOW_2);
            rule__AlExtension__Group__6();

            state._fsp--;


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__Group__5"


    // $ANTLR start "rule__AlExtension__Group__5__Impl"
    // InternalMdal.g:361:1: rule__AlExtension__Group__5__Impl : ( ( rule__AlExtension__Group_5__0 )? ) ;
    public final void rule__AlExtension__Group__5__Impl() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:365:1: ( ( ( rule__AlExtension__Group_5__0 )? ) )
            // InternalMdal.g:366:1: ( ( rule__AlExtension__Group_5__0 )? )
            {
            // InternalMdal.g:366:1: ( ( rule__AlExtension__Group_5__0 )? )
            // InternalMdal.g:367:2: ( rule__AlExtension__Group_5__0 )?
            {
             before(grammarAccess.getAlExtensionAccess().getGroup_5()); 
            // InternalMdal.g:368:2: ( rule__AlExtension__Group_5__0 )?
            int alt5=2;
            int LA5_0 = input.LA(1);

            if ( (LA5_0==21) ) {
                alt5=1;
            }
            switch (alt5) {
                case 1 :
                    // InternalMdal.g:368:3: rule__AlExtension__Group_5__0
                    {
                    pushFollow(FOLLOW_2);
                    rule__AlExtension__Group_5__0();

                    state._fsp--;


                    }
                    break;

            }

             after(grammarAccess.getAlExtensionAccess().getGroup_5()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__Group__5__Impl"


    // $ANTLR start "rule__AlExtension__Group__6"
    // InternalMdal.g:376:1: rule__AlExtension__Group__6 : rule__AlExtension__Group__6__Impl rule__AlExtension__Group__7 ;
    public final void rule__AlExtension__Group__6() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:380:1: ( rule__AlExtension__Group__6__Impl rule__AlExtension__Group__7 )
            // InternalMdal.g:381:2: rule__AlExtension__Group__6__Impl rule__AlExtension__Group__7
            {
            pushFollow(FOLLOW_6);
            rule__AlExtension__Group__6__Impl();

            state._fsp--;

            pushFollow(FOLLOW_2);
            rule__AlExtension__Group__7();

            state._fsp--;


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__Group__6"


    // $ANTLR start "rule__AlExtension__Group__6__Impl"
    // InternalMdal.g:388:1: rule__AlExtension__Group__6__Impl : ( ( rule__AlExtension__Group_6__0 )? ) ;
    public final void rule__AlExtension__Group__6__Impl() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:392:1: ( ( ( rule__AlExtension__Group_6__0 )? ) )
            // InternalMdal.g:393:1: ( ( rule__AlExtension__Group_6__0 )? )
            {
            // InternalMdal.g:393:1: ( ( rule__AlExtension__Group_6__0 )? )
            // InternalMdal.g:394:2: ( rule__AlExtension__Group_6__0 )?
            {
             before(grammarAccess.getAlExtensionAccess().getGroup_6()); 
            // InternalMdal.g:395:2: ( rule__AlExtension__Group_6__0 )?
            int alt6=2;
            int LA6_0 = input.LA(1);

            if ( (LA6_0==22) ) {
                alt6=1;
            }
            switch (alt6) {
                case 1 :
                    // InternalMdal.g:395:3: rule__AlExtension__Group_6__0
                    {
                    pushFollow(FOLLOW_2);
                    rule__AlExtension__Group_6__0();

                    state._fsp--;


                    }
                    break;

            }

             after(grammarAccess.getAlExtensionAccess().getGroup_6()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__Group__6__Impl"


    // $ANTLR start "rule__AlExtension__Group__7"
    // InternalMdal.g:403:1: rule__AlExtension__Group__7 : rule__AlExtension__Group__7__Impl rule__AlExtension__Group__8 ;
    public final void rule__AlExtension__Group__7() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:407:1: ( rule__AlExtension__Group__7__Impl rule__AlExtension__Group__8 )
            // InternalMdal.g:408:2: rule__AlExtension__Group__7__Impl rule__AlExtension__Group__8
            {
            pushFollow(FOLLOW_6);
            rule__AlExtension__Group__7__Impl();

            state._fsp--;

            pushFollow(FOLLOW_2);
            rule__AlExtension__Group__8();

            state._fsp--;


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__Group__7"


    // $ANTLR start "rule__AlExtension__Group__7__Impl"
    // InternalMdal.g:415:1: rule__AlExtension__Group__7__Impl : ( ( rule__AlExtension__Group_7__0 )? ) ;
    public final void rule__AlExtension__Group__7__Impl() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:419:1: ( ( ( rule__AlExtension__Group_7__0 )? ) )
            // InternalMdal.g:420:1: ( ( rule__AlExtension__Group_7__0 )? )
            {
            // InternalMdal.g:420:1: ( ( rule__AlExtension__Group_7__0 )? )
            // InternalMdal.g:421:2: ( rule__AlExtension__Group_7__0 )?
            {
             before(grammarAccess.getAlExtensionAccess().getGroup_7()); 
            // InternalMdal.g:422:2: ( rule__AlExtension__Group_7__0 )?
            int alt7=2;
            int LA7_0 = input.LA(1);

            if ( (LA7_0==23) ) {
                alt7=1;
            }
            switch (alt7) {
                case 1 :
                    // InternalMdal.g:422:3: rule__AlExtension__Group_7__0
                    {
                    pushFollow(FOLLOW_2);
                    rule__AlExtension__Group_7__0();

                    state._fsp--;


                    }
                    break;

            }

             after(grammarAccess.getAlExtensionAccess().getGroup_7()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__Group__7__Impl"


    // $ANTLR start "rule__AlExtension__Group__8"
    // InternalMdal.g:430:1: rule__AlExtension__Group__8 : rule__AlExtension__Group__8__Impl rule__AlExtension__Group__9 ;
    public final void rule__AlExtension__Group__8() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:434:1: ( rule__AlExtension__Group__8__Impl rule__AlExtension__Group__9 )
            // InternalMdal.g:435:2: rule__AlExtension__Group__8__Impl rule__AlExtension__Group__9
            {
            pushFollow(FOLLOW_6);
            rule__AlExtension__Group__8__Impl();

            state._fsp--;

            pushFollow(FOLLOW_2);
            rule__AlExtension__Group__9();

            state._fsp--;


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__Group__8"


    // $ANTLR start "rule__AlExtension__Group__8__Impl"
    // InternalMdal.g:442:1: rule__AlExtension__Group__8__Impl : ( ( rule__AlExtension__Group_8__0 )? ) ;
    public final void rule__AlExtension__Group__8__Impl() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:446:1: ( ( ( rule__AlExtension__Group_8__0 )? ) )
            // InternalMdal.g:447:1: ( ( rule__AlExtension__Group_8__0 )? )
            {
            // InternalMdal.g:447:1: ( ( rule__AlExtension__Group_8__0 )? )
            // InternalMdal.g:448:2: ( rule__AlExtension__Group_8__0 )?
            {
             before(grammarAccess.getAlExtensionAccess().getGroup_8()); 
            // InternalMdal.g:449:2: ( rule__AlExtension__Group_8__0 )?
            int alt8=2;
            int LA8_0 = input.LA(1);

            if ( (LA8_0==24) ) {
                alt8=1;
            }
            switch (alt8) {
                case 1 :
                    // InternalMdal.g:449:3: rule__AlExtension__Group_8__0
                    {
                    pushFollow(FOLLOW_2);
                    rule__AlExtension__Group_8__0();

                    state._fsp--;


                    }
                    break;

            }

             after(grammarAccess.getAlExtensionAccess().getGroup_8()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__Group__8__Impl"


    // $ANTLR start "rule__AlExtension__Group__9"
    // InternalMdal.g:457:1: rule__AlExtension__Group__9 : rule__AlExtension__Group__9__Impl rule__AlExtension__Group__10 ;
    public final void rule__AlExtension__Group__9() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:461:1: ( rule__AlExtension__Group__9__Impl rule__AlExtension__Group__10 )
            // InternalMdal.g:462:2: rule__AlExtension__Group__9__Impl rule__AlExtension__Group__10
            {
            pushFollow(FOLLOW_6);
            rule__AlExtension__Group__9__Impl();

            state._fsp--;

            pushFollow(FOLLOW_2);
            rule__AlExtension__Group__10();

            state._fsp--;


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__Group__9"


    // $ANTLR start "rule__AlExtension__Group__9__Impl"
    // InternalMdal.g:469:1: rule__AlExtension__Group__9__Impl : ( ( rule__AlExtension__Group_9__0 )? ) ;
    public final void rule__AlExtension__Group__9__Impl() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:473:1: ( ( ( rule__AlExtension__Group_9__0 )? ) )
            // InternalMdal.g:474:1: ( ( rule__AlExtension__Group_9__0 )? )
            {
            // InternalMdal.g:474:1: ( ( rule__AlExtension__Group_9__0 )? )
            // InternalMdal.g:475:2: ( rule__AlExtension__Group_9__0 )?
            {
             before(grammarAccess.getAlExtensionAccess().getGroup_9()); 
            // InternalMdal.g:476:2: ( rule__AlExtension__Group_9__0 )?
            int alt9=2;
            int LA9_0 = input.LA(1);

            if ( (LA9_0==25) ) {
                alt9=1;
            }
            switch (alt9) {
                case 1 :
                    // InternalMdal.g:476:3: rule__AlExtension__Group_9__0
                    {
                    pushFollow(FOLLOW_2);
                    rule__AlExtension__Group_9__0();

                    state._fsp--;


                    }
                    break;

            }

             after(grammarAccess.getAlExtensionAccess().getGroup_9()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__Group__9__Impl"


    // $ANTLR start "rule__AlExtension__Group__10"
    // InternalMdal.g:484:1: rule__AlExtension__Group__10 : rule__AlExtension__Group__10__Impl rule__AlExtension__Group__11 ;
    public final void rule__AlExtension__Group__10() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:488:1: ( rule__AlExtension__Group__10__Impl rule__AlExtension__Group__11 )
            // InternalMdal.g:489:2: rule__AlExtension__Group__10__Impl rule__AlExtension__Group__11
            {
            pushFollow(FOLLOW_6);
            rule__AlExtension__Group__10__Impl();

            state._fsp--;

            pushFollow(FOLLOW_2);
            rule__AlExtension__Group__11();

            state._fsp--;


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__Group__10"


    // $ANTLR start "rule__AlExtension__Group__10__Impl"
    // InternalMdal.g:496:1: rule__AlExtension__Group__10__Impl : ( ( rule__AlExtension__Group_10__0 )? ) ;
    public final void rule__AlExtension__Group__10__Impl() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:500:1: ( ( ( rule__AlExtension__Group_10__0 )? ) )
            // InternalMdal.g:501:1: ( ( rule__AlExtension__Group_10__0 )? )
            {
            // InternalMdal.g:501:1: ( ( rule__AlExtension__Group_10__0 )? )
            // InternalMdal.g:502:2: ( rule__AlExtension__Group_10__0 )?
            {
             before(grammarAccess.getAlExtensionAccess().getGroup_10()); 
            // InternalMdal.g:503:2: ( rule__AlExtension__Group_10__0 )?
            int alt10=2;
            int LA10_0 = input.LA(1);

            if ( (LA10_0==26) ) {
                alt10=1;
            }
            switch (alt10) {
                case 1 :
                    // InternalMdal.g:503:3: rule__AlExtension__Group_10__0
                    {
                    pushFollow(FOLLOW_2);
                    rule__AlExtension__Group_10__0();

                    state._fsp--;


                    }
                    break;

            }

             after(grammarAccess.getAlExtensionAccess().getGroup_10()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__Group__10__Impl"


    // $ANTLR start "rule__AlExtension__Group__11"
    // InternalMdal.g:511:1: rule__AlExtension__Group__11 : rule__AlExtension__Group__11__Impl rule__AlExtension__Group__12 ;
    public final void rule__AlExtension__Group__11() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:515:1: ( rule__AlExtension__Group__11__Impl rule__AlExtension__Group__12 )
            // InternalMdal.g:516:2: rule__AlExtension__Group__11__Impl rule__AlExtension__Group__12
            {
            pushFollow(FOLLOW_6);
            rule__AlExtension__Group__11__Impl();

            state._fsp--;

            pushFollow(FOLLOW_2);
            rule__AlExtension__Group__12();

            state._fsp--;


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__Group__11"


    // $ANTLR start "rule__AlExtension__Group__11__Impl"
    // InternalMdal.g:523:1: rule__AlExtension__Group__11__Impl : ( ( rule__AlExtension__Group_11__0 )? ) ;
    public final void rule__AlExtension__Group__11__Impl() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:527:1: ( ( ( rule__AlExtension__Group_11__0 )? ) )
            // InternalMdal.g:528:1: ( ( rule__AlExtension__Group_11__0 )? )
            {
            // InternalMdal.g:528:1: ( ( rule__AlExtension__Group_11__0 )? )
            // InternalMdal.g:529:2: ( rule__AlExtension__Group_11__0 )?
            {
             before(grammarAccess.getAlExtensionAccess().getGroup_11()); 
            // InternalMdal.g:530:2: ( rule__AlExtension__Group_11__0 )?
            int alt11=2;
            int LA11_0 = input.LA(1);

            if ( (LA11_0==27) ) {
                alt11=1;
            }
            switch (alt11) {
                case 1 :
                    // InternalMdal.g:530:3: rule__AlExtension__Group_11__0
                    {
                    pushFollow(FOLLOW_2);
                    rule__AlExtension__Group_11__0();

                    state._fsp--;


                    }
                    break;

            }

             after(grammarAccess.getAlExtensionAccess().getGroup_11()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__Group__11__Impl"


    // $ANTLR start "rule__AlExtension__Group__12"
    // InternalMdal.g:538:1: rule__AlExtension__Group__12 : rule__AlExtension__Group__12__Impl rule__AlExtension__Group__13 ;
    public final void rule__AlExtension__Group__12() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:542:1: ( rule__AlExtension__Group__12__Impl rule__AlExtension__Group__13 )
            // InternalMdal.g:543:2: rule__AlExtension__Group__12__Impl rule__AlExtension__Group__13
            {
            pushFollow(FOLLOW_6);
            rule__AlExtension__Group__12__Impl();

            state._fsp--;

            pushFollow(FOLLOW_2);
            rule__AlExtension__Group__13();

            state._fsp--;


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__Group__12"


    // $ANTLR start "rule__AlExtension__Group__12__Impl"
    // InternalMdal.g:550:1: rule__AlExtension__Group__12__Impl : ( ( rule__AlExtension__Group_12__0 )? ) ;
    public final void rule__AlExtension__Group__12__Impl() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:554:1: ( ( ( rule__AlExtension__Group_12__0 )? ) )
            // InternalMdal.g:555:1: ( ( rule__AlExtension__Group_12__0 )? )
            {
            // InternalMdal.g:555:1: ( ( rule__AlExtension__Group_12__0 )? )
            // InternalMdal.g:556:2: ( rule__AlExtension__Group_12__0 )?
            {
             before(grammarAccess.getAlExtensionAccess().getGroup_12()); 
            // InternalMdal.g:557:2: ( rule__AlExtension__Group_12__0 )?
            int alt12=2;
            int LA12_0 = input.LA(1);

            if ( (LA12_0==28) ) {
                alt12=1;
            }
            switch (alt12) {
                case 1 :
                    // InternalMdal.g:557:3: rule__AlExtension__Group_12__0
                    {
                    pushFollow(FOLLOW_2);
                    rule__AlExtension__Group_12__0();

                    state._fsp--;


                    }
                    break;

            }

             after(grammarAccess.getAlExtensionAccess().getGroup_12()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__Group__12__Impl"


    // $ANTLR start "rule__AlExtension__Group__13"
    // InternalMdal.g:565:1: rule__AlExtension__Group__13 : rule__AlExtension__Group__13__Impl rule__AlExtension__Group__14 ;
    public final void rule__AlExtension__Group__13() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:569:1: ( rule__AlExtension__Group__13__Impl rule__AlExtension__Group__14 )
            // InternalMdal.g:570:2: rule__AlExtension__Group__13__Impl rule__AlExtension__Group__14
            {
            pushFollow(FOLLOW_6);
            rule__AlExtension__Group__13__Impl();

            state._fsp--;

            pushFollow(FOLLOW_2);
            rule__AlExtension__Group__14();

            state._fsp--;


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__Group__13"


    // $ANTLR start "rule__AlExtension__Group__13__Impl"
    // InternalMdal.g:577:1: rule__AlExtension__Group__13__Impl : ( ( rule__AlExtension__Group_13__0 )? ) ;
    public final void rule__AlExtension__Group__13__Impl() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:581:1: ( ( ( rule__AlExtension__Group_13__0 )? ) )
            // InternalMdal.g:582:1: ( ( rule__AlExtension__Group_13__0 )? )
            {
            // InternalMdal.g:582:1: ( ( rule__AlExtension__Group_13__0 )? )
            // InternalMdal.g:583:2: ( rule__AlExtension__Group_13__0 )?
            {
             before(grammarAccess.getAlExtensionAccess().getGroup_13()); 
            // InternalMdal.g:584:2: ( rule__AlExtension__Group_13__0 )?
            int alt13=2;
            int LA13_0 = input.LA(1);

            if ( (LA13_0==29) ) {
                alt13=1;
            }
            switch (alt13) {
                case 1 :
                    // InternalMdal.g:584:3: rule__AlExtension__Group_13__0
                    {
                    pushFollow(FOLLOW_2);
                    rule__AlExtension__Group_13__0();

                    state._fsp--;


                    }
                    break;

            }

             after(grammarAccess.getAlExtensionAccess().getGroup_13()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__Group__13__Impl"


    // $ANTLR start "rule__AlExtension__Group__14"
    // InternalMdal.g:592:1: rule__AlExtension__Group__14 : rule__AlExtension__Group__14__Impl rule__AlExtension__Group__15 ;
    public final void rule__AlExtension__Group__14() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:596:1: ( rule__AlExtension__Group__14__Impl rule__AlExtension__Group__15 )
            // InternalMdal.g:597:2: rule__AlExtension__Group__14__Impl rule__AlExtension__Group__15
            {
            pushFollow(FOLLOW_6);
            rule__AlExtension__Group__14__Impl();

            state._fsp--;

            pushFollow(FOLLOW_2);
            rule__AlExtension__Group__15();

            state._fsp--;


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__Group__14"


    // $ANTLR start "rule__AlExtension__Group__14__Impl"
    // InternalMdal.g:604:1: rule__AlExtension__Group__14__Impl : ( ( rule__AlExtension__Group_14__0 )? ) ;
    public final void rule__AlExtension__Group__14__Impl() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:608:1: ( ( ( rule__AlExtension__Group_14__0 )? ) )
            // InternalMdal.g:609:1: ( ( rule__AlExtension__Group_14__0 )? )
            {
            // InternalMdal.g:609:1: ( ( rule__AlExtension__Group_14__0 )? )
            // InternalMdal.g:610:2: ( rule__AlExtension__Group_14__0 )?
            {
             before(grammarAccess.getAlExtensionAccess().getGroup_14()); 
            // InternalMdal.g:611:2: ( rule__AlExtension__Group_14__0 )?
            int alt14=2;
            int LA14_0 = input.LA(1);

            if ( (LA14_0==30) ) {
                alt14=1;
            }
            switch (alt14) {
                case 1 :
                    // InternalMdal.g:611:3: rule__AlExtension__Group_14__0
                    {
                    pushFollow(FOLLOW_2);
                    rule__AlExtension__Group_14__0();

                    state._fsp--;


                    }
                    break;

            }

             after(grammarAccess.getAlExtensionAccess().getGroup_14()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__Group__14__Impl"


    // $ANTLR start "rule__AlExtension__Group__15"
    // InternalMdal.g:619:1: rule__AlExtension__Group__15 : rule__AlExtension__Group__15__Impl rule__AlExtension__Group__16 ;
    public final void rule__AlExtension__Group__15() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:623:1: ( rule__AlExtension__Group__15__Impl rule__AlExtension__Group__16 )
            // InternalMdal.g:624:2: rule__AlExtension__Group__15__Impl rule__AlExtension__Group__16
            {
            pushFollow(FOLLOW_6);
            rule__AlExtension__Group__15__Impl();

            state._fsp--;

            pushFollow(FOLLOW_2);
            rule__AlExtension__Group__16();

            state._fsp--;


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__Group__15"


    // $ANTLR start "rule__AlExtension__Group__15__Impl"
    // InternalMdal.g:631:1: rule__AlExtension__Group__15__Impl : ( ( rule__AlExtension__Group_15__0 )? ) ;
    public final void rule__AlExtension__Group__15__Impl() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:635:1: ( ( ( rule__AlExtension__Group_15__0 )? ) )
            // InternalMdal.g:636:1: ( ( rule__AlExtension__Group_15__0 )? )
            {
            // InternalMdal.g:636:1: ( ( rule__AlExtension__Group_15__0 )? )
            // InternalMdal.g:637:2: ( rule__AlExtension__Group_15__0 )?
            {
             before(grammarAccess.getAlExtensionAccess().getGroup_15()); 
            // InternalMdal.g:638:2: ( rule__AlExtension__Group_15__0 )?
            int alt15=2;
            int LA15_0 = input.LA(1);

            if ( (LA15_0==31) ) {
                alt15=1;
            }
            switch (alt15) {
                case 1 :
                    // InternalMdal.g:638:3: rule__AlExtension__Group_15__0
                    {
                    pushFollow(FOLLOW_2);
                    rule__AlExtension__Group_15__0();

                    state._fsp--;


                    }
                    break;

            }

             after(grammarAccess.getAlExtensionAccess().getGroup_15()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__Group__15__Impl"


    // $ANTLR start "rule__AlExtension__Group__16"
    // InternalMdal.g:646:1: rule__AlExtension__Group__16 : rule__AlExtension__Group__16__Impl rule__AlExtension__Group__17 ;
    public final void rule__AlExtension__Group__16() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:650:1: ( rule__AlExtension__Group__16__Impl rule__AlExtension__Group__17 )
            // InternalMdal.g:651:2: rule__AlExtension__Group__16__Impl rule__AlExtension__Group__17
            {
            pushFollow(FOLLOW_6);
            rule__AlExtension__Group__16__Impl();

            state._fsp--;

            pushFollow(FOLLOW_2);
            rule__AlExtension__Group__17();

            state._fsp--;


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__Group__16"


    // $ANTLR start "rule__AlExtension__Group__16__Impl"
    // InternalMdal.g:658:1: rule__AlExtension__Group__16__Impl : ( ( rule__AlExtension__Group_16__0 )? ) ;
    public final void rule__AlExtension__Group__16__Impl() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:662:1: ( ( ( rule__AlExtension__Group_16__0 )? ) )
            // InternalMdal.g:663:1: ( ( rule__AlExtension__Group_16__0 )? )
            {
            // InternalMdal.g:663:1: ( ( rule__AlExtension__Group_16__0 )? )
            // InternalMdal.g:664:2: ( rule__AlExtension__Group_16__0 )?
            {
             before(grammarAccess.getAlExtensionAccess().getGroup_16()); 
            // InternalMdal.g:665:2: ( rule__AlExtension__Group_16__0 )?
            int alt16=2;
            int LA16_0 = input.LA(1);

            if ( (LA16_0==32) ) {
                alt16=1;
            }
            switch (alt16) {
                case 1 :
                    // InternalMdal.g:665:3: rule__AlExtension__Group_16__0
                    {
                    pushFollow(FOLLOW_2);
                    rule__AlExtension__Group_16__0();

                    state._fsp--;


                    }
                    break;

            }

             after(grammarAccess.getAlExtensionAccess().getGroup_16()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__Group__16__Impl"


    // $ANTLR start "rule__AlExtension__Group__17"
    // InternalMdal.g:673:1: rule__AlExtension__Group__17 : rule__AlExtension__Group__17__Impl ;
    public final void rule__AlExtension__Group__17() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:677:1: ( rule__AlExtension__Group__17__Impl )
            // InternalMdal.g:678:2: rule__AlExtension__Group__17__Impl
            {
            pushFollow(FOLLOW_2);
            rule__AlExtension__Group__17__Impl();

            state._fsp--;


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__Group__17"


    // $ANTLR start "rule__AlExtension__Group__17__Impl"
    // InternalMdal.g:684:1: rule__AlExtension__Group__17__Impl : ( '}' ) ;
    public final void rule__AlExtension__Group__17__Impl() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:688:1: ( ( '}' ) )
            // InternalMdal.g:689:1: ( '}' )
            {
            // InternalMdal.g:689:1: ( '}' )
            // InternalMdal.g:690:2: '}'
            {
             before(grammarAccess.getAlExtensionAccess().getRightCurlyBracketKeyword_17()); 
            match(input,15,FOLLOW_2); 
             after(grammarAccess.getAlExtensionAccess().getRightCurlyBracketKeyword_17()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__Group__17__Impl"


    // $ANTLR start "rule__AlExtension__Group_3__0"
    // InternalMdal.g:700:1: rule__AlExtension__Group_3__0 : rule__AlExtension__Group_3__0__Impl rule__AlExtension__Group_3__1 ;
    public final void rule__AlExtension__Group_3__0() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:704:1: ( rule__AlExtension__Group_3__0__Impl rule__AlExtension__Group_3__1 )
            // InternalMdal.g:705:2: rule__AlExtension__Group_3__0__Impl rule__AlExtension__Group_3__1
            {
            pushFollow(FOLLOW_4);
            rule__AlExtension__Group_3__0__Impl();

            state._fsp--;

            pushFollow(FOLLOW_2);
            rule__AlExtension__Group_3__1();

            state._fsp--;


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__Group_3__0"


    // $ANTLR start "rule__AlExtension__Group_3__0__Impl"
    // InternalMdal.g:712:1: rule__AlExtension__Group_3__0__Impl : ( 'id' ) ;
    public final void rule__AlExtension__Group_3__0__Impl() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:716:1: ( ( 'id' ) )
            // InternalMdal.g:717:1: ( 'id' )
            {
            // InternalMdal.g:717:1: ( 'id' )
            // InternalMdal.g:718:2: 'id'
            {
             before(grammarAccess.getAlExtensionAccess().getIdKeyword_3_0()); 
            match(input,16,FOLLOW_2); 
             after(grammarAccess.getAlExtensionAccess().getIdKeyword_3_0()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__Group_3__0__Impl"


    // $ANTLR start "rule__AlExtension__Group_3__1"
    // InternalMdal.g:727:1: rule__AlExtension__Group_3__1 : rule__AlExtension__Group_3__1__Impl ;
    public final void rule__AlExtension__Group_3__1() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:731:1: ( rule__AlExtension__Group_3__1__Impl )
            // InternalMdal.g:732:2: rule__AlExtension__Group_3__1__Impl
            {
            pushFollow(FOLLOW_2);
            rule__AlExtension__Group_3__1__Impl();

            state._fsp--;


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__Group_3__1"


    // $ANTLR start "rule__AlExtension__Group_3__1__Impl"
    // InternalMdal.g:738:1: rule__AlExtension__Group_3__1__Impl : ( ( rule__AlExtension__IdAssignment_3_1 ) ) ;
    public final void rule__AlExtension__Group_3__1__Impl() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:742:1: ( ( ( rule__AlExtension__IdAssignment_3_1 ) ) )
            // InternalMdal.g:743:1: ( ( rule__AlExtension__IdAssignment_3_1 ) )
            {
            // InternalMdal.g:743:1: ( ( rule__AlExtension__IdAssignment_3_1 ) )
            // InternalMdal.g:744:2: ( rule__AlExtension__IdAssignment_3_1 )
            {
             before(grammarAccess.getAlExtensionAccess().getIdAssignment_3_1()); 
            // InternalMdal.g:745:2: ( rule__AlExtension__IdAssignment_3_1 )
            // InternalMdal.g:745:3: rule__AlExtension__IdAssignment_3_1
            {
            pushFollow(FOLLOW_2);
            rule__AlExtension__IdAssignment_3_1();

            state._fsp--;


            }

             after(grammarAccess.getAlExtensionAccess().getIdAssignment_3_1()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__Group_3__1__Impl"


    // $ANTLR start "rule__AlExtension__Group_4__0"
    // InternalMdal.g:754:1: rule__AlExtension__Group_4__0 : rule__AlExtension__Group_4__0__Impl rule__AlExtension__Group_4__1 ;
    public final void rule__AlExtension__Group_4__0() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:758:1: ( rule__AlExtension__Group_4__0__Impl rule__AlExtension__Group_4__1 )
            // InternalMdal.g:759:2: rule__AlExtension__Group_4__0__Impl rule__AlExtension__Group_4__1
            {
            pushFollow(FOLLOW_7);
            rule__AlExtension__Group_4__0__Impl();

            state._fsp--;

            pushFollow(FOLLOW_2);
            rule__AlExtension__Group_4__1();

            state._fsp--;


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__Group_4__0"


    // $ANTLR start "rule__AlExtension__Group_4__0__Impl"
    // InternalMdal.g:766:1: rule__AlExtension__Group_4__0__Impl : ( 'idRanges' ) ;
    public final void rule__AlExtension__Group_4__0__Impl() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:770:1: ( ( 'idRanges' ) )
            // InternalMdal.g:771:1: ( 'idRanges' )
            {
            // InternalMdal.g:771:1: ( 'idRanges' )
            // InternalMdal.g:772:2: 'idRanges'
            {
             before(grammarAccess.getAlExtensionAccess().getIdRangesKeyword_4_0()); 
            match(input,17,FOLLOW_2); 
             after(grammarAccess.getAlExtensionAccess().getIdRangesKeyword_4_0()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__Group_4__0__Impl"


    // $ANTLR start "rule__AlExtension__Group_4__1"
    // InternalMdal.g:781:1: rule__AlExtension__Group_4__1 : rule__AlExtension__Group_4__1__Impl rule__AlExtension__Group_4__2 ;
    public final void rule__AlExtension__Group_4__1() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:785:1: ( rule__AlExtension__Group_4__1__Impl rule__AlExtension__Group_4__2 )
            // InternalMdal.g:786:2: rule__AlExtension__Group_4__1__Impl rule__AlExtension__Group_4__2
            {
            pushFollow(FOLLOW_8);
            rule__AlExtension__Group_4__1__Impl();

            state._fsp--;

            pushFollow(FOLLOW_2);
            rule__AlExtension__Group_4__2();

            state._fsp--;


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__Group_4__1"


    // $ANTLR start "rule__AlExtension__Group_4__1__Impl"
    // InternalMdal.g:793:1: rule__AlExtension__Group_4__1__Impl : ( '[' ) ;
    public final void rule__AlExtension__Group_4__1__Impl() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:797:1: ( ( '[' ) )
            // InternalMdal.g:798:1: ( '[' )
            {
            // InternalMdal.g:798:1: ( '[' )
            // InternalMdal.g:799:2: '['
            {
             before(grammarAccess.getAlExtensionAccess().getLeftSquareBracketKeyword_4_1()); 
            match(input,18,FOLLOW_2); 
             after(grammarAccess.getAlExtensionAccess().getLeftSquareBracketKeyword_4_1()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__Group_4__1__Impl"


    // $ANTLR start "rule__AlExtension__Group_4__2"
    // InternalMdal.g:808:1: rule__AlExtension__Group_4__2 : rule__AlExtension__Group_4__2__Impl rule__AlExtension__Group_4__3 ;
    public final void rule__AlExtension__Group_4__2() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:812:1: ( rule__AlExtension__Group_4__2__Impl rule__AlExtension__Group_4__3 )
            // InternalMdal.g:813:2: rule__AlExtension__Group_4__2__Impl rule__AlExtension__Group_4__3
            {
            pushFollow(FOLLOW_9);
            rule__AlExtension__Group_4__2__Impl();

            state._fsp--;

            pushFollow(FOLLOW_2);
            rule__AlExtension__Group_4__3();

            state._fsp--;


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__Group_4__2"


    // $ANTLR start "rule__AlExtension__Group_4__2__Impl"
    // InternalMdal.g:820:1: rule__AlExtension__Group_4__2__Impl : ( ( rule__AlExtension__Group_4_2__0 ) ) ;
    public final void rule__AlExtension__Group_4__2__Impl() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:824:1: ( ( ( rule__AlExtension__Group_4_2__0 ) ) )
            // InternalMdal.g:825:1: ( ( rule__AlExtension__Group_4_2__0 ) )
            {
            // InternalMdal.g:825:1: ( ( rule__AlExtension__Group_4_2__0 ) )
            // InternalMdal.g:826:2: ( rule__AlExtension__Group_4_2__0 )
            {
             before(grammarAccess.getAlExtensionAccess().getGroup_4_2()); 
            // InternalMdal.g:827:2: ( rule__AlExtension__Group_4_2__0 )
            // InternalMdal.g:827:3: rule__AlExtension__Group_4_2__0
            {
            pushFollow(FOLLOW_2);
            rule__AlExtension__Group_4_2__0();

            state._fsp--;


            }

             after(grammarAccess.getAlExtensionAccess().getGroup_4_2()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__Group_4__2__Impl"


    // $ANTLR start "rule__AlExtension__Group_4__3"
    // InternalMdal.g:835:1: rule__AlExtension__Group_4__3 : rule__AlExtension__Group_4__3__Impl ;
    public final void rule__AlExtension__Group_4__3() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:839:1: ( rule__AlExtension__Group_4__3__Impl )
            // InternalMdal.g:840:2: rule__AlExtension__Group_4__3__Impl
            {
            pushFollow(FOLLOW_2);
            rule__AlExtension__Group_4__3__Impl();

            state._fsp--;


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__Group_4__3"


    // $ANTLR start "rule__AlExtension__Group_4__3__Impl"
    // InternalMdal.g:846:1: rule__AlExtension__Group_4__3__Impl : ( ']' ) ;
    public final void rule__AlExtension__Group_4__3__Impl() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:850:1: ( ( ']' ) )
            // InternalMdal.g:851:1: ( ']' )
            {
            // InternalMdal.g:851:1: ( ']' )
            // InternalMdal.g:852:2: ']'
            {
             before(grammarAccess.getAlExtensionAccess().getRightSquareBracketKeyword_4_3()); 
            match(input,19,FOLLOW_2); 
             after(grammarAccess.getAlExtensionAccess().getRightSquareBracketKeyword_4_3()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__Group_4__3__Impl"


    // $ANTLR start "rule__AlExtension__Group_4_2__0"
    // InternalMdal.g:862:1: rule__AlExtension__Group_4_2__0 : rule__AlExtension__Group_4_2__0__Impl rule__AlExtension__Group_4_2__1 ;
    public final void rule__AlExtension__Group_4_2__0() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:866:1: ( rule__AlExtension__Group_4_2__0__Impl rule__AlExtension__Group_4_2__1 )
            // InternalMdal.g:867:2: rule__AlExtension__Group_4_2__0__Impl rule__AlExtension__Group_4_2__1
            {
            pushFollow(FOLLOW_10);
            rule__AlExtension__Group_4_2__0__Impl();

            state._fsp--;

            pushFollow(FOLLOW_2);
            rule__AlExtension__Group_4_2__1();

            state._fsp--;


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__Group_4_2__0"


    // $ANTLR start "rule__AlExtension__Group_4_2__0__Impl"
    // InternalMdal.g:874:1: rule__AlExtension__Group_4_2__0__Impl : ( ( rule__AlExtension__IdRangesAssignment_4_2_0 ) ) ;
    public final void rule__AlExtension__Group_4_2__0__Impl() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:878:1: ( ( ( rule__AlExtension__IdRangesAssignment_4_2_0 ) ) )
            // InternalMdal.g:879:1: ( ( rule__AlExtension__IdRangesAssignment_4_2_0 ) )
            {
            // InternalMdal.g:879:1: ( ( rule__AlExtension__IdRangesAssignment_4_2_0 ) )
            // InternalMdal.g:880:2: ( rule__AlExtension__IdRangesAssignment_4_2_0 )
            {
             before(grammarAccess.getAlExtensionAccess().getIdRangesAssignment_4_2_0()); 
            // InternalMdal.g:881:2: ( rule__AlExtension__IdRangesAssignment_4_2_0 )
            // InternalMdal.g:881:3: rule__AlExtension__IdRangesAssignment_4_2_0
            {
            pushFollow(FOLLOW_2);
            rule__AlExtension__IdRangesAssignment_4_2_0();

            state._fsp--;


            }

             after(grammarAccess.getAlExtensionAccess().getIdRangesAssignment_4_2_0()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__Group_4_2__0__Impl"


    // $ANTLR start "rule__AlExtension__Group_4_2__1"
    // InternalMdal.g:889:1: rule__AlExtension__Group_4_2__1 : rule__AlExtension__Group_4_2__1__Impl ;
    public final void rule__AlExtension__Group_4_2__1() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:893:1: ( rule__AlExtension__Group_4_2__1__Impl )
            // InternalMdal.g:894:2: rule__AlExtension__Group_4_2__1__Impl
            {
            pushFollow(FOLLOW_2);
            rule__AlExtension__Group_4_2__1__Impl();

            state._fsp--;


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__Group_4_2__1"


    // $ANTLR start "rule__AlExtension__Group_4_2__1__Impl"
    // InternalMdal.g:900:1: rule__AlExtension__Group_4_2__1__Impl : ( ( rule__AlExtension__Group_4_2_1__0 )* ) ;
    public final void rule__AlExtension__Group_4_2__1__Impl() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:904:1: ( ( ( rule__AlExtension__Group_4_2_1__0 )* ) )
            // InternalMdal.g:905:1: ( ( rule__AlExtension__Group_4_2_1__0 )* )
            {
            // InternalMdal.g:905:1: ( ( rule__AlExtension__Group_4_2_1__0 )* )
            // InternalMdal.g:906:2: ( rule__AlExtension__Group_4_2_1__0 )*
            {
             before(grammarAccess.getAlExtensionAccess().getGroup_4_2_1()); 
            // InternalMdal.g:907:2: ( rule__AlExtension__Group_4_2_1__0 )*
            loop17:
            do {
                int alt17=2;
                int LA17_0 = input.LA(1);

                if ( (LA17_0==20) ) {
                    alt17=1;
                }


                switch (alt17) {
            	case 1 :
            	    // InternalMdal.g:907:3: rule__AlExtension__Group_4_2_1__0
            	    {
            	    pushFollow(FOLLOW_11);
            	    rule__AlExtension__Group_4_2_1__0();

            	    state._fsp--;


            	    }
            	    break;

            	default :
            	    break loop17;
                }
            } while (true);

             after(grammarAccess.getAlExtensionAccess().getGroup_4_2_1()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__Group_4_2__1__Impl"


    // $ANTLR start "rule__AlExtension__Group_4_2_1__0"
    // InternalMdal.g:916:1: rule__AlExtension__Group_4_2_1__0 : rule__AlExtension__Group_4_2_1__0__Impl rule__AlExtension__Group_4_2_1__1 ;
    public final void rule__AlExtension__Group_4_2_1__0() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:920:1: ( rule__AlExtension__Group_4_2_1__0__Impl rule__AlExtension__Group_4_2_1__1 )
            // InternalMdal.g:921:2: rule__AlExtension__Group_4_2_1__0__Impl rule__AlExtension__Group_4_2_1__1
            {
            pushFollow(FOLLOW_8);
            rule__AlExtension__Group_4_2_1__0__Impl();

            state._fsp--;

            pushFollow(FOLLOW_2);
            rule__AlExtension__Group_4_2_1__1();

            state._fsp--;


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__Group_4_2_1__0"


    // $ANTLR start "rule__AlExtension__Group_4_2_1__0__Impl"
    // InternalMdal.g:928:1: rule__AlExtension__Group_4_2_1__0__Impl : ( ',' ) ;
    public final void rule__AlExtension__Group_4_2_1__0__Impl() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:932:1: ( ( ',' ) )
            // InternalMdal.g:933:1: ( ',' )
            {
            // InternalMdal.g:933:1: ( ',' )
            // InternalMdal.g:934:2: ','
            {
             before(grammarAccess.getAlExtensionAccess().getCommaKeyword_4_2_1_0()); 
            match(input,20,FOLLOW_2); 
             after(grammarAccess.getAlExtensionAccess().getCommaKeyword_4_2_1_0()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__Group_4_2_1__0__Impl"


    // $ANTLR start "rule__AlExtension__Group_4_2_1__1"
    // InternalMdal.g:943:1: rule__AlExtension__Group_4_2_1__1 : rule__AlExtension__Group_4_2_1__1__Impl ;
    public final void rule__AlExtension__Group_4_2_1__1() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:947:1: ( rule__AlExtension__Group_4_2_1__1__Impl )
            // InternalMdal.g:948:2: rule__AlExtension__Group_4_2_1__1__Impl
            {
            pushFollow(FOLLOW_2);
            rule__AlExtension__Group_4_2_1__1__Impl();

            state._fsp--;


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__Group_4_2_1__1"


    // $ANTLR start "rule__AlExtension__Group_4_2_1__1__Impl"
    // InternalMdal.g:954:1: rule__AlExtension__Group_4_2_1__1__Impl : ( ( rule__AlExtension__IdRangesAssignment_4_2_1_1 ) ) ;
    public final void rule__AlExtension__Group_4_2_1__1__Impl() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:958:1: ( ( ( rule__AlExtension__IdRangesAssignment_4_2_1_1 ) ) )
            // InternalMdal.g:959:1: ( ( rule__AlExtension__IdRangesAssignment_4_2_1_1 ) )
            {
            // InternalMdal.g:959:1: ( ( rule__AlExtension__IdRangesAssignment_4_2_1_1 ) )
            // InternalMdal.g:960:2: ( rule__AlExtension__IdRangesAssignment_4_2_1_1 )
            {
             before(grammarAccess.getAlExtensionAccess().getIdRangesAssignment_4_2_1_1()); 
            // InternalMdal.g:961:2: ( rule__AlExtension__IdRangesAssignment_4_2_1_1 )
            // InternalMdal.g:961:3: rule__AlExtension__IdRangesAssignment_4_2_1_1
            {
            pushFollow(FOLLOW_2);
            rule__AlExtension__IdRangesAssignment_4_2_1_1();

            state._fsp--;


            }

             after(grammarAccess.getAlExtensionAccess().getIdRangesAssignment_4_2_1_1()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__Group_4_2_1__1__Impl"


    // $ANTLR start "rule__AlExtension__Group_5__0"
    // InternalMdal.g:970:1: rule__AlExtension__Group_5__0 : rule__AlExtension__Group_5__0__Impl rule__AlExtension__Group_5__1 ;
    public final void rule__AlExtension__Group_5__0() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:974:1: ( rule__AlExtension__Group_5__0__Impl rule__AlExtension__Group_5__1 )
            // InternalMdal.g:975:2: rule__AlExtension__Group_5__0__Impl rule__AlExtension__Group_5__1
            {
            pushFollow(FOLLOW_4);
            rule__AlExtension__Group_5__0__Impl();

            state._fsp--;

            pushFollow(FOLLOW_2);
            rule__AlExtension__Group_5__1();

            state._fsp--;


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__Group_5__0"


    // $ANTLR start "rule__AlExtension__Group_5__0__Impl"
    // InternalMdal.g:982:1: rule__AlExtension__Group_5__0__Impl : ( 'platform' ) ;
    public final void rule__AlExtension__Group_5__0__Impl() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:986:1: ( ( 'platform' ) )
            // InternalMdal.g:987:1: ( 'platform' )
            {
            // InternalMdal.g:987:1: ( 'platform' )
            // InternalMdal.g:988:2: 'platform'
            {
             before(grammarAccess.getAlExtensionAccess().getPlatformKeyword_5_0()); 
            match(input,21,FOLLOW_2); 
             after(grammarAccess.getAlExtensionAccess().getPlatformKeyword_5_0()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__Group_5__0__Impl"


    // $ANTLR start "rule__AlExtension__Group_5__1"
    // InternalMdal.g:997:1: rule__AlExtension__Group_5__1 : rule__AlExtension__Group_5__1__Impl ;
    public final void rule__AlExtension__Group_5__1() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:1001:1: ( rule__AlExtension__Group_5__1__Impl )
            // InternalMdal.g:1002:2: rule__AlExtension__Group_5__1__Impl
            {
            pushFollow(FOLLOW_2);
            rule__AlExtension__Group_5__1__Impl();

            state._fsp--;


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__Group_5__1"


    // $ANTLR start "rule__AlExtension__Group_5__1__Impl"
    // InternalMdal.g:1008:1: rule__AlExtension__Group_5__1__Impl : ( ( rule__AlExtension__PlatformAssignment_5_1 ) ) ;
    public final void rule__AlExtension__Group_5__1__Impl() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:1012:1: ( ( ( rule__AlExtension__PlatformAssignment_5_1 ) ) )
            // InternalMdal.g:1013:1: ( ( rule__AlExtension__PlatformAssignment_5_1 ) )
            {
            // InternalMdal.g:1013:1: ( ( rule__AlExtension__PlatformAssignment_5_1 ) )
            // InternalMdal.g:1014:2: ( rule__AlExtension__PlatformAssignment_5_1 )
            {
             before(grammarAccess.getAlExtensionAccess().getPlatformAssignment_5_1()); 
            // InternalMdal.g:1015:2: ( rule__AlExtension__PlatformAssignment_5_1 )
            // InternalMdal.g:1015:3: rule__AlExtension__PlatformAssignment_5_1
            {
            pushFollow(FOLLOW_2);
            rule__AlExtension__PlatformAssignment_5_1();

            state._fsp--;


            }

             after(grammarAccess.getAlExtensionAccess().getPlatformAssignment_5_1()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__Group_5__1__Impl"


    // $ANTLR start "rule__AlExtension__Group_6__0"
    // InternalMdal.g:1024:1: rule__AlExtension__Group_6__0 : rule__AlExtension__Group_6__0__Impl rule__AlExtension__Group_6__1 ;
    public final void rule__AlExtension__Group_6__0() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:1028:1: ( rule__AlExtension__Group_6__0__Impl rule__AlExtension__Group_6__1 )
            // InternalMdal.g:1029:2: rule__AlExtension__Group_6__0__Impl rule__AlExtension__Group_6__1
            {
            pushFollow(FOLLOW_4);
            rule__AlExtension__Group_6__0__Impl();

            state._fsp--;

            pushFollow(FOLLOW_2);
            rule__AlExtension__Group_6__1();

            state._fsp--;


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__Group_6__0"


    // $ANTLR start "rule__AlExtension__Group_6__0__Impl"
    // InternalMdal.g:1036:1: rule__AlExtension__Group_6__0__Impl : ( 'publisher' ) ;
    public final void rule__AlExtension__Group_6__0__Impl() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:1040:1: ( ( 'publisher' ) )
            // InternalMdal.g:1041:1: ( 'publisher' )
            {
            // InternalMdal.g:1041:1: ( 'publisher' )
            // InternalMdal.g:1042:2: 'publisher'
            {
             before(grammarAccess.getAlExtensionAccess().getPublisherKeyword_6_0()); 
            match(input,22,FOLLOW_2); 
             after(grammarAccess.getAlExtensionAccess().getPublisherKeyword_6_0()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__Group_6__0__Impl"


    // $ANTLR start "rule__AlExtension__Group_6__1"
    // InternalMdal.g:1051:1: rule__AlExtension__Group_6__1 : rule__AlExtension__Group_6__1__Impl ;
    public final void rule__AlExtension__Group_6__1() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:1055:1: ( rule__AlExtension__Group_6__1__Impl )
            // InternalMdal.g:1056:2: rule__AlExtension__Group_6__1__Impl
            {
            pushFollow(FOLLOW_2);
            rule__AlExtension__Group_6__1__Impl();

            state._fsp--;


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__Group_6__1"


    // $ANTLR start "rule__AlExtension__Group_6__1__Impl"
    // InternalMdal.g:1062:1: rule__AlExtension__Group_6__1__Impl : ( ( rule__AlExtension__PublisherAssignment_6_1 ) ) ;
    public final void rule__AlExtension__Group_6__1__Impl() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:1066:1: ( ( ( rule__AlExtension__PublisherAssignment_6_1 ) ) )
            // InternalMdal.g:1067:1: ( ( rule__AlExtension__PublisherAssignment_6_1 ) )
            {
            // InternalMdal.g:1067:1: ( ( rule__AlExtension__PublisherAssignment_6_1 ) )
            // InternalMdal.g:1068:2: ( rule__AlExtension__PublisherAssignment_6_1 )
            {
             before(grammarAccess.getAlExtensionAccess().getPublisherAssignment_6_1()); 
            // InternalMdal.g:1069:2: ( rule__AlExtension__PublisherAssignment_6_1 )
            // InternalMdal.g:1069:3: rule__AlExtension__PublisherAssignment_6_1
            {
            pushFollow(FOLLOW_2);
            rule__AlExtension__PublisherAssignment_6_1();

            state._fsp--;


            }

             after(grammarAccess.getAlExtensionAccess().getPublisherAssignment_6_1()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__Group_6__1__Impl"


    // $ANTLR start "rule__AlExtension__Group_7__0"
    // InternalMdal.g:1078:1: rule__AlExtension__Group_7__0 : rule__AlExtension__Group_7__0__Impl rule__AlExtension__Group_7__1 ;
    public final void rule__AlExtension__Group_7__0() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:1082:1: ( rule__AlExtension__Group_7__0__Impl rule__AlExtension__Group_7__1 )
            // InternalMdal.g:1083:2: rule__AlExtension__Group_7__0__Impl rule__AlExtension__Group_7__1
            {
            pushFollow(FOLLOW_4);
            rule__AlExtension__Group_7__0__Impl();

            state._fsp--;

            pushFollow(FOLLOW_2);
            rule__AlExtension__Group_7__1();

            state._fsp--;


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__Group_7__0"


    // $ANTLR start "rule__AlExtension__Group_7__0__Impl"
    // InternalMdal.g:1090:1: rule__AlExtension__Group_7__0__Impl : ( 'version' ) ;
    public final void rule__AlExtension__Group_7__0__Impl() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:1094:1: ( ( 'version' ) )
            // InternalMdal.g:1095:1: ( 'version' )
            {
            // InternalMdal.g:1095:1: ( 'version' )
            // InternalMdal.g:1096:2: 'version'
            {
             before(grammarAccess.getAlExtensionAccess().getVersionKeyword_7_0()); 
            match(input,23,FOLLOW_2); 
             after(grammarAccess.getAlExtensionAccess().getVersionKeyword_7_0()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__Group_7__0__Impl"


    // $ANTLR start "rule__AlExtension__Group_7__1"
    // InternalMdal.g:1105:1: rule__AlExtension__Group_7__1 : rule__AlExtension__Group_7__1__Impl ;
    public final void rule__AlExtension__Group_7__1() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:1109:1: ( rule__AlExtension__Group_7__1__Impl )
            // InternalMdal.g:1110:2: rule__AlExtension__Group_7__1__Impl
            {
            pushFollow(FOLLOW_2);
            rule__AlExtension__Group_7__1__Impl();

            state._fsp--;


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__Group_7__1"


    // $ANTLR start "rule__AlExtension__Group_7__1__Impl"
    // InternalMdal.g:1116:1: rule__AlExtension__Group_7__1__Impl : ( ( rule__AlExtension__VersionAssignment_7_1 ) ) ;
    public final void rule__AlExtension__Group_7__1__Impl() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:1120:1: ( ( ( rule__AlExtension__VersionAssignment_7_1 ) ) )
            // InternalMdal.g:1121:1: ( ( rule__AlExtension__VersionAssignment_7_1 ) )
            {
            // InternalMdal.g:1121:1: ( ( rule__AlExtension__VersionAssignment_7_1 ) )
            // InternalMdal.g:1122:2: ( rule__AlExtension__VersionAssignment_7_1 )
            {
             before(grammarAccess.getAlExtensionAccess().getVersionAssignment_7_1()); 
            // InternalMdal.g:1123:2: ( rule__AlExtension__VersionAssignment_7_1 )
            // InternalMdal.g:1123:3: rule__AlExtension__VersionAssignment_7_1
            {
            pushFollow(FOLLOW_2);
            rule__AlExtension__VersionAssignment_7_1();

            state._fsp--;


            }

             after(grammarAccess.getAlExtensionAccess().getVersionAssignment_7_1()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__Group_7__1__Impl"


    // $ANTLR start "rule__AlExtension__Group_8__0"
    // InternalMdal.g:1132:1: rule__AlExtension__Group_8__0 : rule__AlExtension__Group_8__0__Impl rule__AlExtension__Group_8__1 ;
    public final void rule__AlExtension__Group_8__0() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:1136:1: ( rule__AlExtension__Group_8__0__Impl rule__AlExtension__Group_8__1 )
            // InternalMdal.g:1137:2: rule__AlExtension__Group_8__0__Impl rule__AlExtension__Group_8__1
            {
            pushFollow(FOLLOW_4);
            rule__AlExtension__Group_8__0__Impl();

            state._fsp--;

            pushFollow(FOLLOW_2);
            rule__AlExtension__Group_8__1();

            state._fsp--;


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__Group_8__0"


    // $ANTLR start "rule__AlExtension__Group_8__0__Impl"
    // InternalMdal.g:1144:1: rule__AlExtension__Group_8__0__Impl : ( 'brief' ) ;
    public final void rule__AlExtension__Group_8__0__Impl() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:1148:1: ( ( 'brief' ) )
            // InternalMdal.g:1149:1: ( 'brief' )
            {
            // InternalMdal.g:1149:1: ( 'brief' )
            // InternalMdal.g:1150:2: 'brief'
            {
             before(grammarAccess.getAlExtensionAccess().getBriefKeyword_8_0()); 
            match(input,24,FOLLOW_2); 
             after(grammarAccess.getAlExtensionAccess().getBriefKeyword_8_0()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__Group_8__0__Impl"


    // $ANTLR start "rule__AlExtension__Group_8__1"
    // InternalMdal.g:1159:1: rule__AlExtension__Group_8__1 : rule__AlExtension__Group_8__1__Impl ;
    public final void rule__AlExtension__Group_8__1() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:1163:1: ( rule__AlExtension__Group_8__1__Impl )
            // InternalMdal.g:1164:2: rule__AlExtension__Group_8__1__Impl
            {
            pushFollow(FOLLOW_2);
            rule__AlExtension__Group_8__1__Impl();

            state._fsp--;


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__Group_8__1"


    // $ANTLR start "rule__AlExtension__Group_8__1__Impl"
    // InternalMdal.g:1170:1: rule__AlExtension__Group_8__1__Impl : ( ( rule__AlExtension__BriefAssignment_8_1 ) ) ;
    public final void rule__AlExtension__Group_8__1__Impl() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:1174:1: ( ( ( rule__AlExtension__BriefAssignment_8_1 ) ) )
            // InternalMdal.g:1175:1: ( ( rule__AlExtension__BriefAssignment_8_1 ) )
            {
            // InternalMdal.g:1175:1: ( ( rule__AlExtension__BriefAssignment_8_1 ) )
            // InternalMdal.g:1176:2: ( rule__AlExtension__BriefAssignment_8_1 )
            {
             before(grammarAccess.getAlExtensionAccess().getBriefAssignment_8_1()); 
            // InternalMdal.g:1177:2: ( rule__AlExtension__BriefAssignment_8_1 )
            // InternalMdal.g:1177:3: rule__AlExtension__BriefAssignment_8_1
            {
            pushFollow(FOLLOW_2);
            rule__AlExtension__BriefAssignment_8_1();

            state._fsp--;


            }

             after(grammarAccess.getAlExtensionAccess().getBriefAssignment_8_1()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__Group_8__1__Impl"


    // $ANTLR start "rule__AlExtension__Group_9__0"
    // InternalMdal.g:1186:1: rule__AlExtension__Group_9__0 : rule__AlExtension__Group_9__0__Impl rule__AlExtension__Group_9__1 ;
    public final void rule__AlExtension__Group_9__0() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:1190:1: ( rule__AlExtension__Group_9__0__Impl rule__AlExtension__Group_9__1 )
            // InternalMdal.g:1191:2: rule__AlExtension__Group_9__0__Impl rule__AlExtension__Group_9__1
            {
            pushFollow(FOLLOW_4);
            rule__AlExtension__Group_9__0__Impl();

            state._fsp--;

            pushFollow(FOLLOW_2);
            rule__AlExtension__Group_9__1();

            state._fsp--;


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__Group_9__0"


    // $ANTLR start "rule__AlExtension__Group_9__0__Impl"
    // InternalMdal.g:1198:1: rule__AlExtension__Group_9__0__Impl : ( 'description' ) ;
    public final void rule__AlExtension__Group_9__0__Impl() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:1202:1: ( ( 'description' ) )
            // InternalMdal.g:1203:1: ( 'description' )
            {
            // InternalMdal.g:1203:1: ( 'description' )
            // InternalMdal.g:1204:2: 'description'
            {
             before(grammarAccess.getAlExtensionAccess().getDescriptionKeyword_9_0()); 
            match(input,25,FOLLOW_2); 
             after(grammarAccess.getAlExtensionAccess().getDescriptionKeyword_9_0()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__Group_9__0__Impl"


    // $ANTLR start "rule__AlExtension__Group_9__1"
    // InternalMdal.g:1213:1: rule__AlExtension__Group_9__1 : rule__AlExtension__Group_9__1__Impl ;
    public final void rule__AlExtension__Group_9__1() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:1217:1: ( rule__AlExtension__Group_9__1__Impl )
            // InternalMdal.g:1218:2: rule__AlExtension__Group_9__1__Impl
            {
            pushFollow(FOLLOW_2);
            rule__AlExtension__Group_9__1__Impl();

            state._fsp--;


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__Group_9__1"


    // $ANTLR start "rule__AlExtension__Group_9__1__Impl"
    // InternalMdal.g:1224:1: rule__AlExtension__Group_9__1__Impl : ( ( rule__AlExtension__DescriptionAssignment_9_1 ) ) ;
    public final void rule__AlExtension__Group_9__1__Impl() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:1228:1: ( ( ( rule__AlExtension__DescriptionAssignment_9_1 ) ) )
            // InternalMdal.g:1229:1: ( ( rule__AlExtension__DescriptionAssignment_9_1 ) )
            {
            // InternalMdal.g:1229:1: ( ( rule__AlExtension__DescriptionAssignment_9_1 ) )
            // InternalMdal.g:1230:2: ( rule__AlExtension__DescriptionAssignment_9_1 )
            {
             before(grammarAccess.getAlExtensionAccess().getDescriptionAssignment_9_1()); 
            // InternalMdal.g:1231:2: ( rule__AlExtension__DescriptionAssignment_9_1 )
            // InternalMdal.g:1231:3: rule__AlExtension__DescriptionAssignment_9_1
            {
            pushFollow(FOLLOW_2);
            rule__AlExtension__DescriptionAssignment_9_1();

            state._fsp--;


            }

             after(grammarAccess.getAlExtensionAccess().getDescriptionAssignment_9_1()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__Group_9__1__Impl"


    // $ANTLR start "rule__AlExtension__Group_10__0"
    // InternalMdal.g:1240:1: rule__AlExtension__Group_10__0 : rule__AlExtension__Group_10__0__Impl rule__AlExtension__Group_10__1 ;
    public final void rule__AlExtension__Group_10__0() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:1244:1: ( rule__AlExtension__Group_10__0__Impl rule__AlExtension__Group_10__1 )
            // InternalMdal.g:1245:2: rule__AlExtension__Group_10__0__Impl rule__AlExtension__Group_10__1
            {
            pushFollow(FOLLOW_4);
            rule__AlExtension__Group_10__0__Impl();

            state._fsp--;

            pushFollow(FOLLOW_2);
            rule__AlExtension__Group_10__1();

            state._fsp--;


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__Group_10__0"


    // $ANTLR start "rule__AlExtension__Group_10__0__Impl"
    // InternalMdal.g:1252:1: rule__AlExtension__Group_10__0__Impl : ( 'privacyStatement' ) ;
    public final void rule__AlExtension__Group_10__0__Impl() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:1256:1: ( ( 'privacyStatement' ) )
            // InternalMdal.g:1257:1: ( 'privacyStatement' )
            {
            // InternalMdal.g:1257:1: ( 'privacyStatement' )
            // InternalMdal.g:1258:2: 'privacyStatement'
            {
             before(grammarAccess.getAlExtensionAccess().getPrivacyStatementKeyword_10_0()); 
            match(input,26,FOLLOW_2); 
             after(grammarAccess.getAlExtensionAccess().getPrivacyStatementKeyword_10_0()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__Group_10__0__Impl"


    // $ANTLR start "rule__AlExtension__Group_10__1"
    // InternalMdal.g:1267:1: rule__AlExtension__Group_10__1 : rule__AlExtension__Group_10__1__Impl ;
    public final void rule__AlExtension__Group_10__1() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:1271:1: ( rule__AlExtension__Group_10__1__Impl )
            // InternalMdal.g:1272:2: rule__AlExtension__Group_10__1__Impl
            {
            pushFollow(FOLLOW_2);
            rule__AlExtension__Group_10__1__Impl();

            state._fsp--;


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__Group_10__1"


    // $ANTLR start "rule__AlExtension__Group_10__1__Impl"
    // InternalMdal.g:1278:1: rule__AlExtension__Group_10__1__Impl : ( ( rule__AlExtension__PrivacyStatementAssignment_10_1 ) ) ;
    public final void rule__AlExtension__Group_10__1__Impl() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:1282:1: ( ( ( rule__AlExtension__PrivacyStatementAssignment_10_1 ) ) )
            // InternalMdal.g:1283:1: ( ( rule__AlExtension__PrivacyStatementAssignment_10_1 ) )
            {
            // InternalMdal.g:1283:1: ( ( rule__AlExtension__PrivacyStatementAssignment_10_1 ) )
            // InternalMdal.g:1284:2: ( rule__AlExtension__PrivacyStatementAssignment_10_1 )
            {
             before(grammarAccess.getAlExtensionAccess().getPrivacyStatementAssignment_10_1()); 
            // InternalMdal.g:1285:2: ( rule__AlExtension__PrivacyStatementAssignment_10_1 )
            // InternalMdal.g:1285:3: rule__AlExtension__PrivacyStatementAssignment_10_1
            {
            pushFollow(FOLLOW_2);
            rule__AlExtension__PrivacyStatementAssignment_10_1();

            state._fsp--;


            }

             after(grammarAccess.getAlExtensionAccess().getPrivacyStatementAssignment_10_1()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__Group_10__1__Impl"


    // $ANTLR start "rule__AlExtension__Group_11__0"
    // InternalMdal.g:1294:1: rule__AlExtension__Group_11__0 : rule__AlExtension__Group_11__0__Impl rule__AlExtension__Group_11__1 ;
    public final void rule__AlExtension__Group_11__0() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:1298:1: ( rule__AlExtension__Group_11__0__Impl rule__AlExtension__Group_11__1 )
            // InternalMdal.g:1299:2: rule__AlExtension__Group_11__0__Impl rule__AlExtension__Group_11__1
            {
            pushFollow(FOLLOW_4);
            rule__AlExtension__Group_11__0__Impl();

            state._fsp--;

            pushFollow(FOLLOW_2);
            rule__AlExtension__Group_11__1();

            state._fsp--;


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__Group_11__0"


    // $ANTLR start "rule__AlExtension__Group_11__0__Impl"
    // InternalMdal.g:1306:1: rule__AlExtension__Group_11__0__Impl : ( 'eula' ) ;
    public final void rule__AlExtension__Group_11__0__Impl() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:1310:1: ( ( 'eula' ) )
            // InternalMdal.g:1311:1: ( 'eula' )
            {
            // InternalMdal.g:1311:1: ( 'eula' )
            // InternalMdal.g:1312:2: 'eula'
            {
             before(grammarAccess.getAlExtensionAccess().getEulaKeyword_11_0()); 
            match(input,27,FOLLOW_2); 
             after(grammarAccess.getAlExtensionAccess().getEulaKeyword_11_0()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__Group_11__0__Impl"


    // $ANTLR start "rule__AlExtension__Group_11__1"
    // InternalMdal.g:1321:1: rule__AlExtension__Group_11__1 : rule__AlExtension__Group_11__1__Impl ;
    public final void rule__AlExtension__Group_11__1() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:1325:1: ( rule__AlExtension__Group_11__1__Impl )
            // InternalMdal.g:1326:2: rule__AlExtension__Group_11__1__Impl
            {
            pushFollow(FOLLOW_2);
            rule__AlExtension__Group_11__1__Impl();

            state._fsp--;


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__Group_11__1"


    // $ANTLR start "rule__AlExtension__Group_11__1__Impl"
    // InternalMdal.g:1332:1: rule__AlExtension__Group_11__1__Impl : ( ( rule__AlExtension__EulaAssignment_11_1 ) ) ;
    public final void rule__AlExtension__Group_11__1__Impl() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:1336:1: ( ( ( rule__AlExtension__EulaAssignment_11_1 ) ) )
            // InternalMdal.g:1337:1: ( ( rule__AlExtension__EulaAssignment_11_1 ) )
            {
            // InternalMdal.g:1337:1: ( ( rule__AlExtension__EulaAssignment_11_1 ) )
            // InternalMdal.g:1338:2: ( rule__AlExtension__EulaAssignment_11_1 )
            {
             before(grammarAccess.getAlExtensionAccess().getEulaAssignment_11_1()); 
            // InternalMdal.g:1339:2: ( rule__AlExtension__EulaAssignment_11_1 )
            // InternalMdal.g:1339:3: rule__AlExtension__EulaAssignment_11_1
            {
            pushFollow(FOLLOW_2);
            rule__AlExtension__EulaAssignment_11_1();

            state._fsp--;


            }

             after(grammarAccess.getAlExtensionAccess().getEulaAssignment_11_1()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__Group_11__1__Impl"


    // $ANTLR start "rule__AlExtension__Group_12__0"
    // InternalMdal.g:1348:1: rule__AlExtension__Group_12__0 : rule__AlExtension__Group_12__0__Impl rule__AlExtension__Group_12__1 ;
    public final void rule__AlExtension__Group_12__0() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:1352:1: ( rule__AlExtension__Group_12__0__Impl rule__AlExtension__Group_12__1 )
            // InternalMdal.g:1353:2: rule__AlExtension__Group_12__0__Impl rule__AlExtension__Group_12__1
            {
            pushFollow(FOLLOW_4);
            rule__AlExtension__Group_12__0__Impl();

            state._fsp--;

            pushFollow(FOLLOW_2);
            rule__AlExtension__Group_12__1();

            state._fsp--;


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__Group_12__0"


    // $ANTLR start "rule__AlExtension__Group_12__0__Impl"
    // InternalMdal.g:1360:1: rule__AlExtension__Group_12__0__Impl : ( 'help' ) ;
    public final void rule__AlExtension__Group_12__0__Impl() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:1364:1: ( ( 'help' ) )
            // InternalMdal.g:1365:1: ( 'help' )
            {
            // InternalMdal.g:1365:1: ( 'help' )
            // InternalMdal.g:1366:2: 'help'
            {
             before(grammarAccess.getAlExtensionAccess().getHelpKeyword_12_0()); 
            match(input,28,FOLLOW_2); 
             after(grammarAccess.getAlExtensionAccess().getHelpKeyword_12_0()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__Group_12__0__Impl"


    // $ANTLR start "rule__AlExtension__Group_12__1"
    // InternalMdal.g:1375:1: rule__AlExtension__Group_12__1 : rule__AlExtension__Group_12__1__Impl ;
    public final void rule__AlExtension__Group_12__1() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:1379:1: ( rule__AlExtension__Group_12__1__Impl )
            // InternalMdal.g:1380:2: rule__AlExtension__Group_12__1__Impl
            {
            pushFollow(FOLLOW_2);
            rule__AlExtension__Group_12__1__Impl();

            state._fsp--;


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__Group_12__1"


    // $ANTLR start "rule__AlExtension__Group_12__1__Impl"
    // InternalMdal.g:1386:1: rule__AlExtension__Group_12__1__Impl : ( ( rule__AlExtension__HelpAssignment_12_1 ) ) ;
    public final void rule__AlExtension__Group_12__1__Impl() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:1390:1: ( ( ( rule__AlExtension__HelpAssignment_12_1 ) ) )
            // InternalMdal.g:1391:1: ( ( rule__AlExtension__HelpAssignment_12_1 ) )
            {
            // InternalMdal.g:1391:1: ( ( rule__AlExtension__HelpAssignment_12_1 ) )
            // InternalMdal.g:1392:2: ( rule__AlExtension__HelpAssignment_12_1 )
            {
             before(grammarAccess.getAlExtensionAccess().getHelpAssignment_12_1()); 
            // InternalMdal.g:1393:2: ( rule__AlExtension__HelpAssignment_12_1 )
            // InternalMdal.g:1393:3: rule__AlExtension__HelpAssignment_12_1
            {
            pushFollow(FOLLOW_2);
            rule__AlExtension__HelpAssignment_12_1();

            state._fsp--;


            }

             after(grammarAccess.getAlExtensionAccess().getHelpAssignment_12_1()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__Group_12__1__Impl"


    // $ANTLR start "rule__AlExtension__Group_13__0"
    // InternalMdal.g:1402:1: rule__AlExtension__Group_13__0 : rule__AlExtension__Group_13__0__Impl rule__AlExtension__Group_13__1 ;
    public final void rule__AlExtension__Group_13__0() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:1406:1: ( rule__AlExtension__Group_13__0__Impl rule__AlExtension__Group_13__1 )
            // InternalMdal.g:1407:2: rule__AlExtension__Group_13__0__Impl rule__AlExtension__Group_13__1
            {
            pushFollow(FOLLOW_4);
            rule__AlExtension__Group_13__0__Impl();

            state._fsp--;

            pushFollow(FOLLOW_2);
            rule__AlExtension__Group_13__1();

            state._fsp--;


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__Group_13__0"


    // $ANTLR start "rule__AlExtension__Group_13__0__Impl"
    // InternalMdal.g:1414:1: rule__AlExtension__Group_13__0__Impl : ( 'url' ) ;
    public final void rule__AlExtension__Group_13__0__Impl() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:1418:1: ( ( 'url' ) )
            // InternalMdal.g:1419:1: ( 'url' )
            {
            // InternalMdal.g:1419:1: ( 'url' )
            // InternalMdal.g:1420:2: 'url'
            {
             before(grammarAccess.getAlExtensionAccess().getUrlKeyword_13_0()); 
            match(input,29,FOLLOW_2); 
             after(grammarAccess.getAlExtensionAccess().getUrlKeyword_13_0()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__Group_13__0__Impl"


    // $ANTLR start "rule__AlExtension__Group_13__1"
    // InternalMdal.g:1429:1: rule__AlExtension__Group_13__1 : rule__AlExtension__Group_13__1__Impl ;
    public final void rule__AlExtension__Group_13__1() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:1433:1: ( rule__AlExtension__Group_13__1__Impl )
            // InternalMdal.g:1434:2: rule__AlExtension__Group_13__1__Impl
            {
            pushFollow(FOLLOW_2);
            rule__AlExtension__Group_13__1__Impl();

            state._fsp--;


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__Group_13__1"


    // $ANTLR start "rule__AlExtension__Group_13__1__Impl"
    // InternalMdal.g:1440:1: rule__AlExtension__Group_13__1__Impl : ( ( rule__AlExtension__UrlAssignment_13_1 ) ) ;
    public final void rule__AlExtension__Group_13__1__Impl() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:1444:1: ( ( ( rule__AlExtension__UrlAssignment_13_1 ) ) )
            // InternalMdal.g:1445:1: ( ( rule__AlExtension__UrlAssignment_13_1 ) )
            {
            // InternalMdal.g:1445:1: ( ( rule__AlExtension__UrlAssignment_13_1 ) )
            // InternalMdal.g:1446:2: ( rule__AlExtension__UrlAssignment_13_1 )
            {
             before(grammarAccess.getAlExtensionAccess().getUrlAssignment_13_1()); 
            // InternalMdal.g:1447:2: ( rule__AlExtension__UrlAssignment_13_1 )
            // InternalMdal.g:1447:3: rule__AlExtension__UrlAssignment_13_1
            {
            pushFollow(FOLLOW_2);
            rule__AlExtension__UrlAssignment_13_1();

            state._fsp--;


            }

             after(grammarAccess.getAlExtensionAccess().getUrlAssignment_13_1()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__Group_13__1__Impl"


    // $ANTLR start "rule__AlExtension__Group_14__0"
    // InternalMdal.g:1456:1: rule__AlExtension__Group_14__0 : rule__AlExtension__Group_14__0__Impl rule__AlExtension__Group_14__1 ;
    public final void rule__AlExtension__Group_14__0() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:1460:1: ( rule__AlExtension__Group_14__0__Impl rule__AlExtension__Group_14__1 )
            // InternalMdal.g:1461:2: rule__AlExtension__Group_14__0__Impl rule__AlExtension__Group_14__1
            {
            pushFollow(FOLLOW_4);
            rule__AlExtension__Group_14__0__Impl();

            state._fsp--;

            pushFollow(FOLLOW_2);
            rule__AlExtension__Group_14__1();

            state._fsp--;


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__Group_14__0"


    // $ANTLR start "rule__AlExtension__Group_14__0__Impl"
    // InternalMdal.g:1468:1: rule__AlExtension__Group_14__0__Impl : ( 'contextSensitiveHelpUrl' ) ;
    public final void rule__AlExtension__Group_14__0__Impl() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:1472:1: ( ( 'contextSensitiveHelpUrl' ) )
            // InternalMdal.g:1473:1: ( 'contextSensitiveHelpUrl' )
            {
            // InternalMdal.g:1473:1: ( 'contextSensitiveHelpUrl' )
            // InternalMdal.g:1474:2: 'contextSensitiveHelpUrl'
            {
             before(grammarAccess.getAlExtensionAccess().getContextSensitiveHelpUrlKeyword_14_0()); 
            match(input,30,FOLLOW_2); 
             after(grammarAccess.getAlExtensionAccess().getContextSensitiveHelpUrlKeyword_14_0()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__Group_14__0__Impl"


    // $ANTLR start "rule__AlExtension__Group_14__1"
    // InternalMdal.g:1483:1: rule__AlExtension__Group_14__1 : rule__AlExtension__Group_14__1__Impl ;
    public final void rule__AlExtension__Group_14__1() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:1487:1: ( rule__AlExtension__Group_14__1__Impl )
            // InternalMdal.g:1488:2: rule__AlExtension__Group_14__1__Impl
            {
            pushFollow(FOLLOW_2);
            rule__AlExtension__Group_14__1__Impl();

            state._fsp--;


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__Group_14__1"


    // $ANTLR start "rule__AlExtension__Group_14__1__Impl"
    // InternalMdal.g:1494:1: rule__AlExtension__Group_14__1__Impl : ( ( rule__AlExtension__ContextSensitiveHelpUrlAssignment_14_1 ) ) ;
    public final void rule__AlExtension__Group_14__1__Impl() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:1498:1: ( ( ( rule__AlExtension__ContextSensitiveHelpUrlAssignment_14_1 ) ) )
            // InternalMdal.g:1499:1: ( ( rule__AlExtension__ContextSensitiveHelpUrlAssignment_14_1 ) )
            {
            // InternalMdal.g:1499:1: ( ( rule__AlExtension__ContextSensitiveHelpUrlAssignment_14_1 ) )
            // InternalMdal.g:1500:2: ( rule__AlExtension__ContextSensitiveHelpUrlAssignment_14_1 )
            {
             before(grammarAccess.getAlExtensionAccess().getContextSensitiveHelpUrlAssignment_14_1()); 
            // InternalMdal.g:1501:2: ( rule__AlExtension__ContextSensitiveHelpUrlAssignment_14_1 )
            // InternalMdal.g:1501:3: rule__AlExtension__ContextSensitiveHelpUrlAssignment_14_1
            {
            pushFollow(FOLLOW_2);
            rule__AlExtension__ContextSensitiveHelpUrlAssignment_14_1();

            state._fsp--;


            }

             after(grammarAccess.getAlExtensionAccess().getContextSensitiveHelpUrlAssignment_14_1()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__Group_14__1__Impl"


    // $ANTLR start "rule__AlExtension__Group_15__0"
    // InternalMdal.g:1510:1: rule__AlExtension__Group_15__0 : rule__AlExtension__Group_15__0__Impl rule__AlExtension__Group_15__1 ;
    public final void rule__AlExtension__Group_15__0() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:1514:1: ( rule__AlExtension__Group_15__0__Impl rule__AlExtension__Group_15__1 )
            // InternalMdal.g:1515:2: rule__AlExtension__Group_15__0__Impl rule__AlExtension__Group_15__1
            {
            pushFollow(FOLLOW_12);
            rule__AlExtension__Group_15__0__Impl();

            state._fsp--;

            pushFollow(FOLLOW_2);
            rule__AlExtension__Group_15__1();

            state._fsp--;


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__Group_15__0"


    // $ANTLR start "rule__AlExtension__Group_15__0__Impl"
    // InternalMdal.g:1522:1: rule__AlExtension__Group_15__0__Impl : ( 'showMyCode' ) ;
    public final void rule__AlExtension__Group_15__0__Impl() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:1526:1: ( ( 'showMyCode' ) )
            // InternalMdal.g:1527:1: ( 'showMyCode' )
            {
            // InternalMdal.g:1527:1: ( 'showMyCode' )
            // InternalMdal.g:1528:2: 'showMyCode'
            {
             before(grammarAccess.getAlExtensionAccess().getShowMyCodeKeyword_15_0()); 
            match(input,31,FOLLOW_2); 
             after(grammarAccess.getAlExtensionAccess().getShowMyCodeKeyword_15_0()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__Group_15__0__Impl"


    // $ANTLR start "rule__AlExtension__Group_15__1"
    // InternalMdal.g:1537:1: rule__AlExtension__Group_15__1 : rule__AlExtension__Group_15__1__Impl ;
    public final void rule__AlExtension__Group_15__1() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:1541:1: ( rule__AlExtension__Group_15__1__Impl )
            // InternalMdal.g:1542:2: rule__AlExtension__Group_15__1__Impl
            {
            pushFollow(FOLLOW_2);
            rule__AlExtension__Group_15__1__Impl();

            state._fsp--;


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__Group_15__1"


    // $ANTLR start "rule__AlExtension__Group_15__1__Impl"
    // InternalMdal.g:1548:1: rule__AlExtension__Group_15__1__Impl : ( ( rule__AlExtension__ShowMyCodeAssignment_15_1 ) ) ;
    public final void rule__AlExtension__Group_15__1__Impl() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:1552:1: ( ( ( rule__AlExtension__ShowMyCodeAssignment_15_1 ) ) )
            // InternalMdal.g:1553:1: ( ( rule__AlExtension__ShowMyCodeAssignment_15_1 ) )
            {
            // InternalMdal.g:1553:1: ( ( rule__AlExtension__ShowMyCodeAssignment_15_1 ) )
            // InternalMdal.g:1554:2: ( rule__AlExtension__ShowMyCodeAssignment_15_1 )
            {
             before(grammarAccess.getAlExtensionAccess().getShowMyCodeAssignment_15_1()); 
            // InternalMdal.g:1555:2: ( rule__AlExtension__ShowMyCodeAssignment_15_1 )
            // InternalMdal.g:1555:3: rule__AlExtension__ShowMyCodeAssignment_15_1
            {
            pushFollow(FOLLOW_2);
            rule__AlExtension__ShowMyCodeAssignment_15_1();

            state._fsp--;


            }

             after(grammarAccess.getAlExtensionAccess().getShowMyCodeAssignment_15_1()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__Group_15__1__Impl"


    // $ANTLR start "rule__AlExtension__Group_16__0"
    // InternalMdal.g:1564:1: rule__AlExtension__Group_16__0 : rule__AlExtension__Group_16__0__Impl rule__AlExtension__Group_16__1 ;
    public final void rule__AlExtension__Group_16__0() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:1568:1: ( rule__AlExtension__Group_16__0__Impl rule__AlExtension__Group_16__1 )
            // InternalMdal.g:1569:2: rule__AlExtension__Group_16__0__Impl rule__AlExtension__Group_16__1
            {
            pushFollow(FOLLOW_4);
            rule__AlExtension__Group_16__0__Impl();

            state._fsp--;

            pushFollow(FOLLOW_2);
            rule__AlExtension__Group_16__1();

            state._fsp--;


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__Group_16__0"


    // $ANTLR start "rule__AlExtension__Group_16__0__Impl"
    // InternalMdal.g:1576:1: rule__AlExtension__Group_16__0__Impl : ( 'runtime' ) ;
    public final void rule__AlExtension__Group_16__0__Impl() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:1580:1: ( ( 'runtime' ) )
            // InternalMdal.g:1581:1: ( 'runtime' )
            {
            // InternalMdal.g:1581:1: ( 'runtime' )
            // InternalMdal.g:1582:2: 'runtime'
            {
             before(grammarAccess.getAlExtensionAccess().getRuntimeKeyword_16_0()); 
            match(input,32,FOLLOW_2); 
             after(grammarAccess.getAlExtensionAccess().getRuntimeKeyword_16_0()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__Group_16__0__Impl"


    // $ANTLR start "rule__AlExtension__Group_16__1"
    // InternalMdal.g:1591:1: rule__AlExtension__Group_16__1 : rule__AlExtension__Group_16__1__Impl ;
    public final void rule__AlExtension__Group_16__1() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:1595:1: ( rule__AlExtension__Group_16__1__Impl )
            // InternalMdal.g:1596:2: rule__AlExtension__Group_16__1__Impl
            {
            pushFollow(FOLLOW_2);
            rule__AlExtension__Group_16__1__Impl();

            state._fsp--;


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__Group_16__1"


    // $ANTLR start "rule__AlExtension__Group_16__1__Impl"
    // InternalMdal.g:1602:1: rule__AlExtension__Group_16__1__Impl : ( ( rule__AlExtension__RuntimeAssignment_16_1 ) ) ;
    public final void rule__AlExtension__Group_16__1__Impl() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:1606:1: ( ( ( rule__AlExtension__RuntimeAssignment_16_1 ) ) )
            // InternalMdal.g:1607:1: ( ( rule__AlExtension__RuntimeAssignment_16_1 ) )
            {
            // InternalMdal.g:1607:1: ( ( rule__AlExtension__RuntimeAssignment_16_1 ) )
            // InternalMdal.g:1608:2: ( rule__AlExtension__RuntimeAssignment_16_1 )
            {
             before(grammarAccess.getAlExtensionAccess().getRuntimeAssignment_16_1()); 
            // InternalMdal.g:1609:2: ( rule__AlExtension__RuntimeAssignment_16_1 )
            // InternalMdal.g:1609:3: rule__AlExtension__RuntimeAssignment_16_1
            {
            pushFollow(FOLLOW_2);
            rule__AlExtension__RuntimeAssignment_16_1();

            state._fsp--;


            }

             after(grammarAccess.getAlExtensionAccess().getRuntimeAssignment_16_1()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__Group_16__1__Impl"


    // $ANTLR start "rule__TypeText__Group__0"
    // InternalMdal.g:1618:1: rule__TypeText__Group__0 : rule__TypeText__Group__0__Impl rule__TypeText__Group__1 ;
    public final void rule__TypeText__Group__0() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:1622:1: ( rule__TypeText__Group__0__Impl rule__TypeText__Group__1 )
            // InternalMdal.g:1623:2: rule__TypeText__Group__0__Impl rule__TypeText__Group__1
            {
            pushFollow(FOLLOW_13);
            rule__TypeText__Group__0__Impl();

            state._fsp--;

            pushFollow(FOLLOW_2);
            rule__TypeText__Group__1();

            state._fsp--;


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__TypeText__Group__0"


    // $ANTLR start "rule__TypeText__Group__0__Impl"
    // InternalMdal.g:1630:1: rule__TypeText__Group__0__Impl : ( () ) ;
    public final void rule__TypeText__Group__0__Impl() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:1634:1: ( ( () ) )
            // InternalMdal.g:1635:1: ( () )
            {
            // InternalMdal.g:1635:1: ( () )
            // InternalMdal.g:1636:2: ()
            {
             before(grammarAccess.getTypeTextAccess().getTypeTextAction_0()); 
            // InternalMdal.g:1637:2: ()
            // InternalMdal.g:1637:3: 
            {
            }

             after(grammarAccess.getTypeTextAccess().getTypeTextAction_0()); 

            }


            }

        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__TypeText__Group__0__Impl"


    // $ANTLR start "rule__TypeText__Group__1"
    // InternalMdal.g:1645:1: rule__TypeText__Group__1 : rule__TypeText__Group__1__Impl rule__TypeText__Group__2 ;
    public final void rule__TypeText__Group__1() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:1649:1: ( rule__TypeText__Group__1__Impl rule__TypeText__Group__2 )
            // InternalMdal.g:1650:2: rule__TypeText__Group__1__Impl rule__TypeText__Group__2
            {
            pushFollow(FOLLOW_7);
            rule__TypeText__Group__1__Impl();

            state._fsp--;

            pushFollow(FOLLOW_2);
            rule__TypeText__Group__2();

            state._fsp--;


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__TypeText__Group__1"


    // $ANTLR start "rule__TypeText__Group__1__Impl"
    // InternalMdal.g:1657:1: rule__TypeText__Group__1__Impl : ( 'Text' ) ;
    public final void rule__TypeText__Group__1__Impl() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:1661:1: ( ( 'Text' ) )
            // InternalMdal.g:1662:1: ( 'Text' )
            {
            // InternalMdal.g:1662:1: ( 'Text' )
            // InternalMdal.g:1663:2: 'Text'
            {
             before(grammarAccess.getTypeTextAccess().getTextKeyword_1()); 
            match(input,33,FOLLOW_2); 
             after(grammarAccess.getTypeTextAccess().getTextKeyword_1()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__TypeText__Group__1__Impl"


    // $ANTLR start "rule__TypeText__Group__2"
    // InternalMdal.g:1672:1: rule__TypeText__Group__2 : rule__TypeText__Group__2__Impl ;
    public final void rule__TypeText__Group__2() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:1676:1: ( rule__TypeText__Group__2__Impl )
            // InternalMdal.g:1677:2: rule__TypeText__Group__2__Impl
            {
            pushFollow(FOLLOW_2);
            rule__TypeText__Group__2__Impl();

            state._fsp--;


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__TypeText__Group__2"


    // $ANTLR start "rule__TypeText__Group__2__Impl"
    // InternalMdal.g:1683:1: rule__TypeText__Group__2__Impl : ( ( rule__TypeText__Group_2__0 )? ) ;
    public final void rule__TypeText__Group__2__Impl() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:1687:1: ( ( ( rule__TypeText__Group_2__0 )? ) )
            // InternalMdal.g:1688:1: ( ( rule__TypeText__Group_2__0 )? )
            {
            // InternalMdal.g:1688:1: ( ( rule__TypeText__Group_2__0 )? )
            // InternalMdal.g:1689:2: ( rule__TypeText__Group_2__0 )?
            {
             before(grammarAccess.getTypeTextAccess().getGroup_2()); 
            // InternalMdal.g:1690:2: ( rule__TypeText__Group_2__0 )?
            int alt18=2;
            int LA18_0 = input.LA(1);

            if ( (LA18_0==18) ) {
                alt18=1;
            }
            switch (alt18) {
                case 1 :
                    // InternalMdal.g:1690:3: rule__TypeText__Group_2__0
                    {
                    pushFollow(FOLLOW_2);
                    rule__TypeText__Group_2__0();

                    state._fsp--;


                    }
                    break;

            }

             after(grammarAccess.getTypeTextAccess().getGroup_2()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__TypeText__Group__2__Impl"


    // $ANTLR start "rule__TypeText__Group_2__0"
    // InternalMdal.g:1699:1: rule__TypeText__Group_2__0 : rule__TypeText__Group_2__0__Impl rule__TypeText__Group_2__1 ;
    public final void rule__TypeText__Group_2__0() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:1703:1: ( rule__TypeText__Group_2__0__Impl rule__TypeText__Group_2__1 )
            // InternalMdal.g:1704:2: rule__TypeText__Group_2__0__Impl rule__TypeText__Group_2__1
            {
            pushFollow(FOLLOW_8);
            rule__TypeText__Group_2__0__Impl();

            state._fsp--;

            pushFollow(FOLLOW_2);
            rule__TypeText__Group_2__1();

            state._fsp--;


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__TypeText__Group_2__0"


    // $ANTLR start "rule__TypeText__Group_2__0__Impl"
    // InternalMdal.g:1711:1: rule__TypeText__Group_2__0__Impl : ( '[' ) ;
    public final void rule__TypeText__Group_2__0__Impl() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:1715:1: ( ( '[' ) )
            // InternalMdal.g:1716:1: ( '[' )
            {
            // InternalMdal.g:1716:1: ( '[' )
            // InternalMdal.g:1717:2: '['
            {
             before(grammarAccess.getTypeTextAccess().getLeftSquareBracketKeyword_2_0()); 
            match(input,18,FOLLOW_2); 
             after(grammarAccess.getTypeTextAccess().getLeftSquareBracketKeyword_2_0()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__TypeText__Group_2__0__Impl"


    // $ANTLR start "rule__TypeText__Group_2__1"
    // InternalMdal.g:1726:1: rule__TypeText__Group_2__1 : rule__TypeText__Group_2__1__Impl rule__TypeText__Group_2__2 ;
    public final void rule__TypeText__Group_2__1() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:1730:1: ( rule__TypeText__Group_2__1__Impl rule__TypeText__Group_2__2 )
            // InternalMdal.g:1731:2: rule__TypeText__Group_2__1__Impl rule__TypeText__Group_2__2
            {
            pushFollow(FOLLOW_9);
            rule__TypeText__Group_2__1__Impl();

            state._fsp--;

            pushFollow(FOLLOW_2);
            rule__TypeText__Group_2__2();

            state._fsp--;


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__TypeText__Group_2__1"


    // $ANTLR start "rule__TypeText__Group_2__1__Impl"
    // InternalMdal.g:1738:1: rule__TypeText__Group_2__1__Impl : ( ( rule__TypeText__LengthAssignment_2_1 ) ) ;
    public final void rule__TypeText__Group_2__1__Impl() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:1742:1: ( ( ( rule__TypeText__LengthAssignment_2_1 ) ) )
            // InternalMdal.g:1743:1: ( ( rule__TypeText__LengthAssignment_2_1 ) )
            {
            // InternalMdal.g:1743:1: ( ( rule__TypeText__LengthAssignment_2_1 ) )
            // InternalMdal.g:1744:2: ( rule__TypeText__LengthAssignment_2_1 )
            {
             before(grammarAccess.getTypeTextAccess().getLengthAssignment_2_1()); 
            // InternalMdal.g:1745:2: ( rule__TypeText__LengthAssignment_2_1 )
            // InternalMdal.g:1745:3: rule__TypeText__LengthAssignment_2_1
            {
            pushFollow(FOLLOW_2);
            rule__TypeText__LengthAssignment_2_1();

            state._fsp--;


            }

             after(grammarAccess.getTypeTextAccess().getLengthAssignment_2_1()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__TypeText__Group_2__1__Impl"


    // $ANTLR start "rule__TypeText__Group_2__2"
    // InternalMdal.g:1753:1: rule__TypeText__Group_2__2 : rule__TypeText__Group_2__2__Impl ;
    public final void rule__TypeText__Group_2__2() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:1757:1: ( rule__TypeText__Group_2__2__Impl )
            // InternalMdal.g:1758:2: rule__TypeText__Group_2__2__Impl
            {
            pushFollow(FOLLOW_2);
            rule__TypeText__Group_2__2__Impl();

            state._fsp--;


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__TypeText__Group_2__2"


    // $ANTLR start "rule__TypeText__Group_2__2__Impl"
    // InternalMdal.g:1764:1: rule__TypeText__Group_2__2__Impl : ( ']' ) ;
    public final void rule__TypeText__Group_2__2__Impl() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:1768:1: ( ( ']' ) )
            // InternalMdal.g:1769:1: ( ']' )
            {
            // InternalMdal.g:1769:1: ( ']' )
            // InternalMdal.g:1770:2: ']'
            {
             before(grammarAccess.getTypeTextAccess().getRightSquareBracketKeyword_2_2()); 
            match(input,19,FOLLOW_2); 
             after(grammarAccess.getTypeTextAccess().getRightSquareBracketKeyword_2_2()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__TypeText__Group_2__2__Impl"


    // $ANTLR start "rule__IdRange__Group__0"
    // InternalMdal.g:1780:1: rule__IdRange__Group__0 : rule__IdRange__Group__0__Impl rule__IdRange__Group__1 ;
    public final void rule__IdRange__Group__0() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:1784:1: ( rule__IdRange__Group__0__Impl rule__IdRange__Group__1 )
            // InternalMdal.g:1785:2: rule__IdRange__Group__0__Impl rule__IdRange__Group__1
            {
            pushFollow(FOLLOW_14);
            rule__IdRange__Group__0__Impl();

            state._fsp--;

            pushFollow(FOLLOW_2);
            rule__IdRange__Group__1();

            state._fsp--;


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__IdRange__Group__0"


    // $ANTLR start "rule__IdRange__Group__0__Impl"
    // InternalMdal.g:1792:1: rule__IdRange__Group__0__Impl : ( ( rule__IdRange__MinAssignment_0 ) ) ;
    public final void rule__IdRange__Group__0__Impl() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:1796:1: ( ( ( rule__IdRange__MinAssignment_0 ) ) )
            // InternalMdal.g:1797:1: ( ( rule__IdRange__MinAssignment_0 ) )
            {
            // InternalMdal.g:1797:1: ( ( rule__IdRange__MinAssignment_0 ) )
            // InternalMdal.g:1798:2: ( rule__IdRange__MinAssignment_0 )
            {
             before(grammarAccess.getIdRangeAccess().getMinAssignment_0()); 
            // InternalMdal.g:1799:2: ( rule__IdRange__MinAssignment_0 )
            // InternalMdal.g:1799:3: rule__IdRange__MinAssignment_0
            {
            pushFollow(FOLLOW_2);
            rule__IdRange__MinAssignment_0();

            state._fsp--;


            }

             after(grammarAccess.getIdRangeAccess().getMinAssignment_0()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__IdRange__Group__0__Impl"


    // $ANTLR start "rule__IdRange__Group__1"
    // InternalMdal.g:1807:1: rule__IdRange__Group__1 : rule__IdRange__Group__1__Impl ;
    public final void rule__IdRange__Group__1() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:1811:1: ( rule__IdRange__Group__1__Impl )
            // InternalMdal.g:1812:2: rule__IdRange__Group__1__Impl
            {
            pushFollow(FOLLOW_2);
            rule__IdRange__Group__1__Impl();

            state._fsp--;


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__IdRange__Group__1"


    // $ANTLR start "rule__IdRange__Group__1__Impl"
    // InternalMdal.g:1818:1: rule__IdRange__Group__1__Impl : ( ( rule__IdRange__Group_1__0 )? ) ;
    public final void rule__IdRange__Group__1__Impl() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:1822:1: ( ( ( rule__IdRange__Group_1__0 )? ) )
            // InternalMdal.g:1823:1: ( ( rule__IdRange__Group_1__0 )? )
            {
            // InternalMdal.g:1823:1: ( ( rule__IdRange__Group_1__0 )? )
            // InternalMdal.g:1824:2: ( rule__IdRange__Group_1__0 )?
            {
             before(grammarAccess.getIdRangeAccess().getGroup_1()); 
            // InternalMdal.g:1825:2: ( rule__IdRange__Group_1__0 )?
            int alt19=2;
            int LA19_0 = input.LA(1);

            if ( (LA19_0==34) ) {
                alt19=1;
            }
            switch (alt19) {
                case 1 :
                    // InternalMdal.g:1825:3: rule__IdRange__Group_1__0
                    {
                    pushFollow(FOLLOW_2);
                    rule__IdRange__Group_1__0();

                    state._fsp--;


                    }
                    break;

            }

             after(grammarAccess.getIdRangeAccess().getGroup_1()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__IdRange__Group__1__Impl"


    // $ANTLR start "rule__IdRange__Group_1__0"
    // InternalMdal.g:1834:1: rule__IdRange__Group_1__0 : rule__IdRange__Group_1__0__Impl rule__IdRange__Group_1__1 ;
    public final void rule__IdRange__Group_1__0() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:1838:1: ( rule__IdRange__Group_1__0__Impl rule__IdRange__Group_1__1 )
            // InternalMdal.g:1839:2: rule__IdRange__Group_1__0__Impl rule__IdRange__Group_1__1
            {
            pushFollow(FOLLOW_8);
            rule__IdRange__Group_1__0__Impl();

            state._fsp--;

            pushFollow(FOLLOW_2);
            rule__IdRange__Group_1__1();

            state._fsp--;


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__IdRange__Group_1__0"


    // $ANTLR start "rule__IdRange__Group_1__0__Impl"
    // InternalMdal.g:1846:1: rule__IdRange__Group_1__0__Impl : ( '..' ) ;
    public final void rule__IdRange__Group_1__0__Impl() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:1850:1: ( ( '..' ) )
            // InternalMdal.g:1851:1: ( '..' )
            {
            // InternalMdal.g:1851:1: ( '..' )
            // InternalMdal.g:1852:2: '..'
            {
             before(grammarAccess.getIdRangeAccess().getFullStopFullStopKeyword_1_0()); 
            match(input,34,FOLLOW_2); 
             after(grammarAccess.getIdRangeAccess().getFullStopFullStopKeyword_1_0()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__IdRange__Group_1__0__Impl"


    // $ANTLR start "rule__IdRange__Group_1__1"
    // InternalMdal.g:1861:1: rule__IdRange__Group_1__1 : rule__IdRange__Group_1__1__Impl ;
    public final void rule__IdRange__Group_1__1() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:1865:1: ( rule__IdRange__Group_1__1__Impl )
            // InternalMdal.g:1866:2: rule__IdRange__Group_1__1__Impl
            {
            pushFollow(FOLLOW_2);
            rule__IdRange__Group_1__1__Impl();

            state._fsp--;


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__IdRange__Group_1__1"


    // $ANTLR start "rule__IdRange__Group_1__1__Impl"
    // InternalMdal.g:1872:1: rule__IdRange__Group_1__1__Impl : ( ( rule__IdRange__MaxAssignment_1_1 ) ) ;
    public final void rule__IdRange__Group_1__1__Impl() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:1876:1: ( ( ( rule__IdRange__MaxAssignment_1_1 ) ) )
            // InternalMdal.g:1877:1: ( ( rule__IdRange__MaxAssignment_1_1 ) )
            {
            // InternalMdal.g:1877:1: ( ( rule__IdRange__MaxAssignment_1_1 ) )
            // InternalMdal.g:1878:2: ( rule__IdRange__MaxAssignment_1_1 )
            {
             before(grammarAccess.getIdRangeAccess().getMaxAssignment_1_1()); 
            // InternalMdal.g:1879:2: ( rule__IdRange__MaxAssignment_1_1 )
            // InternalMdal.g:1879:3: rule__IdRange__MaxAssignment_1_1
            {
            pushFollow(FOLLOW_2);
            rule__IdRange__MaxAssignment_1_1();

            state._fsp--;


            }

             after(grammarAccess.getIdRangeAccess().getMaxAssignment_1_1()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__IdRange__Group_1__1__Impl"


    // $ANTLR start "rule__Model__AlExtensionsAssignment"
    // InternalMdal.g:1888:1: rule__Model__AlExtensionsAssignment : ( ruleAlExtension ) ;
    public final void rule__Model__AlExtensionsAssignment() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:1892:1: ( ( ruleAlExtension ) )
            // InternalMdal.g:1893:2: ( ruleAlExtension )
            {
            // InternalMdal.g:1893:2: ( ruleAlExtension )
            // InternalMdal.g:1894:3: ruleAlExtension
            {
             before(grammarAccess.getModelAccess().getAlExtensionsAlExtensionParserRuleCall_0()); 
            pushFollow(FOLLOW_2);
            ruleAlExtension();

            state._fsp--;

             after(grammarAccess.getModelAccess().getAlExtensionsAlExtensionParserRuleCall_0()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__Model__AlExtensionsAssignment"


    // $ANTLR start "rule__AlExtension__NameAssignment_1"
    // InternalMdal.g:1903:1: rule__AlExtension__NameAssignment_1 : ( RULE_STRING ) ;
    public final void rule__AlExtension__NameAssignment_1() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:1907:1: ( ( RULE_STRING ) )
            // InternalMdal.g:1908:2: ( RULE_STRING )
            {
            // InternalMdal.g:1908:2: ( RULE_STRING )
            // InternalMdal.g:1909:3: RULE_STRING
            {
             before(grammarAccess.getAlExtensionAccess().getNameSTRINGTerminalRuleCall_1_0()); 
            match(input,RULE_STRING,FOLLOW_2); 
             after(grammarAccess.getAlExtensionAccess().getNameSTRINGTerminalRuleCall_1_0()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__NameAssignment_1"


    // $ANTLR start "rule__AlExtension__IdAssignment_3_1"
    // InternalMdal.g:1918:1: rule__AlExtension__IdAssignment_3_1 : ( RULE_STRING ) ;
    public final void rule__AlExtension__IdAssignment_3_1() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:1922:1: ( ( RULE_STRING ) )
            // InternalMdal.g:1923:2: ( RULE_STRING )
            {
            // InternalMdal.g:1923:2: ( RULE_STRING )
            // InternalMdal.g:1924:3: RULE_STRING
            {
             before(grammarAccess.getAlExtensionAccess().getIdSTRINGTerminalRuleCall_3_1_0()); 
            match(input,RULE_STRING,FOLLOW_2); 
             after(grammarAccess.getAlExtensionAccess().getIdSTRINGTerminalRuleCall_3_1_0()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__IdAssignment_3_1"


    // $ANTLR start "rule__AlExtension__IdRangesAssignment_4_2_0"
    // InternalMdal.g:1933:1: rule__AlExtension__IdRangesAssignment_4_2_0 : ( ruleIdRange ) ;
    public final void rule__AlExtension__IdRangesAssignment_4_2_0() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:1937:1: ( ( ruleIdRange ) )
            // InternalMdal.g:1938:2: ( ruleIdRange )
            {
            // InternalMdal.g:1938:2: ( ruleIdRange )
            // InternalMdal.g:1939:3: ruleIdRange
            {
             before(grammarAccess.getAlExtensionAccess().getIdRangesIdRangeParserRuleCall_4_2_0_0()); 
            pushFollow(FOLLOW_2);
            ruleIdRange();

            state._fsp--;

             after(grammarAccess.getAlExtensionAccess().getIdRangesIdRangeParserRuleCall_4_2_0_0()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__IdRangesAssignment_4_2_0"


    // $ANTLR start "rule__AlExtension__IdRangesAssignment_4_2_1_1"
    // InternalMdal.g:1948:1: rule__AlExtension__IdRangesAssignment_4_2_1_1 : ( ruleIdRange ) ;
    public final void rule__AlExtension__IdRangesAssignment_4_2_1_1() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:1952:1: ( ( ruleIdRange ) )
            // InternalMdal.g:1953:2: ( ruleIdRange )
            {
            // InternalMdal.g:1953:2: ( ruleIdRange )
            // InternalMdal.g:1954:3: ruleIdRange
            {
             before(grammarAccess.getAlExtensionAccess().getIdRangesIdRangeParserRuleCall_4_2_1_1_0()); 
            pushFollow(FOLLOW_2);
            ruleIdRange();

            state._fsp--;

             after(grammarAccess.getAlExtensionAccess().getIdRangesIdRangeParserRuleCall_4_2_1_1_0()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__IdRangesAssignment_4_2_1_1"


    // $ANTLR start "rule__AlExtension__PlatformAssignment_5_1"
    // InternalMdal.g:1963:1: rule__AlExtension__PlatformAssignment_5_1 : ( RULE_STRING ) ;
    public final void rule__AlExtension__PlatformAssignment_5_1() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:1967:1: ( ( RULE_STRING ) )
            // InternalMdal.g:1968:2: ( RULE_STRING )
            {
            // InternalMdal.g:1968:2: ( RULE_STRING )
            // InternalMdal.g:1969:3: RULE_STRING
            {
             before(grammarAccess.getAlExtensionAccess().getPlatformSTRINGTerminalRuleCall_5_1_0()); 
            match(input,RULE_STRING,FOLLOW_2); 
             after(grammarAccess.getAlExtensionAccess().getPlatformSTRINGTerminalRuleCall_5_1_0()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__PlatformAssignment_5_1"


    // $ANTLR start "rule__AlExtension__PublisherAssignment_6_1"
    // InternalMdal.g:1978:1: rule__AlExtension__PublisherAssignment_6_1 : ( RULE_STRING ) ;
    public final void rule__AlExtension__PublisherAssignment_6_1() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:1982:1: ( ( RULE_STRING ) )
            // InternalMdal.g:1983:2: ( RULE_STRING )
            {
            // InternalMdal.g:1983:2: ( RULE_STRING )
            // InternalMdal.g:1984:3: RULE_STRING
            {
             before(grammarAccess.getAlExtensionAccess().getPublisherSTRINGTerminalRuleCall_6_1_0()); 
            match(input,RULE_STRING,FOLLOW_2); 
             after(grammarAccess.getAlExtensionAccess().getPublisherSTRINGTerminalRuleCall_6_1_0()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__PublisherAssignment_6_1"


    // $ANTLR start "rule__AlExtension__VersionAssignment_7_1"
    // InternalMdal.g:1993:1: rule__AlExtension__VersionAssignment_7_1 : ( RULE_STRING ) ;
    public final void rule__AlExtension__VersionAssignment_7_1() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:1997:1: ( ( RULE_STRING ) )
            // InternalMdal.g:1998:2: ( RULE_STRING )
            {
            // InternalMdal.g:1998:2: ( RULE_STRING )
            // InternalMdal.g:1999:3: RULE_STRING
            {
             before(grammarAccess.getAlExtensionAccess().getVersionSTRINGTerminalRuleCall_7_1_0()); 
            match(input,RULE_STRING,FOLLOW_2); 
             after(grammarAccess.getAlExtensionAccess().getVersionSTRINGTerminalRuleCall_7_1_0()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__VersionAssignment_7_1"


    // $ANTLR start "rule__AlExtension__BriefAssignment_8_1"
    // InternalMdal.g:2008:1: rule__AlExtension__BriefAssignment_8_1 : ( RULE_STRING ) ;
    public final void rule__AlExtension__BriefAssignment_8_1() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:2012:1: ( ( RULE_STRING ) )
            // InternalMdal.g:2013:2: ( RULE_STRING )
            {
            // InternalMdal.g:2013:2: ( RULE_STRING )
            // InternalMdal.g:2014:3: RULE_STRING
            {
             before(grammarAccess.getAlExtensionAccess().getBriefSTRINGTerminalRuleCall_8_1_0()); 
            match(input,RULE_STRING,FOLLOW_2); 
             after(grammarAccess.getAlExtensionAccess().getBriefSTRINGTerminalRuleCall_8_1_0()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__BriefAssignment_8_1"


    // $ANTLR start "rule__AlExtension__DescriptionAssignment_9_1"
    // InternalMdal.g:2023:1: rule__AlExtension__DescriptionAssignment_9_1 : ( RULE_STRING ) ;
    public final void rule__AlExtension__DescriptionAssignment_9_1() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:2027:1: ( ( RULE_STRING ) )
            // InternalMdal.g:2028:2: ( RULE_STRING )
            {
            // InternalMdal.g:2028:2: ( RULE_STRING )
            // InternalMdal.g:2029:3: RULE_STRING
            {
             before(grammarAccess.getAlExtensionAccess().getDescriptionSTRINGTerminalRuleCall_9_1_0()); 
            match(input,RULE_STRING,FOLLOW_2); 
             after(grammarAccess.getAlExtensionAccess().getDescriptionSTRINGTerminalRuleCall_9_1_0()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__DescriptionAssignment_9_1"


    // $ANTLR start "rule__AlExtension__PrivacyStatementAssignment_10_1"
    // InternalMdal.g:2038:1: rule__AlExtension__PrivacyStatementAssignment_10_1 : ( RULE_STRING ) ;
    public final void rule__AlExtension__PrivacyStatementAssignment_10_1() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:2042:1: ( ( RULE_STRING ) )
            // InternalMdal.g:2043:2: ( RULE_STRING )
            {
            // InternalMdal.g:2043:2: ( RULE_STRING )
            // InternalMdal.g:2044:3: RULE_STRING
            {
             before(grammarAccess.getAlExtensionAccess().getPrivacyStatementSTRINGTerminalRuleCall_10_1_0()); 
            match(input,RULE_STRING,FOLLOW_2); 
             after(grammarAccess.getAlExtensionAccess().getPrivacyStatementSTRINGTerminalRuleCall_10_1_0()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__PrivacyStatementAssignment_10_1"


    // $ANTLR start "rule__AlExtension__EulaAssignment_11_1"
    // InternalMdal.g:2053:1: rule__AlExtension__EulaAssignment_11_1 : ( RULE_STRING ) ;
    public final void rule__AlExtension__EulaAssignment_11_1() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:2057:1: ( ( RULE_STRING ) )
            // InternalMdal.g:2058:2: ( RULE_STRING )
            {
            // InternalMdal.g:2058:2: ( RULE_STRING )
            // InternalMdal.g:2059:3: RULE_STRING
            {
             before(grammarAccess.getAlExtensionAccess().getEulaSTRINGTerminalRuleCall_11_1_0()); 
            match(input,RULE_STRING,FOLLOW_2); 
             after(grammarAccess.getAlExtensionAccess().getEulaSTRINGTerminalRuleCall_11_1_0()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__EulaAssignment_11_1"


    // $ANTLR start "rule__AlExtension__HelpAssignment_12_1"
    // InternalMdal.g:2068:1: rule__AlExtension__HelpAssignment_12_1 : ( RULE_STRING ) ;
    public final void rule__AlExtension__HelpAssignment_12_1() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:2072:1: ( ( RULE_STRING ) )
            // InternalMdal.g:2073:2: ( RULE_STRING )
            {
            // InternalMdal.g:2073:2: ( RULE_STRING )
            // InternalMdal.g:2074:3: RULE_STRING
            {
             before(grammarAccess.getAlExtensionAccess().getHelpSTRINGTerminalRuleCall_12_1_0()); 
            match(input,RULE_STRING,FOLLOW_2); 
             after(grammarAccess.getAlExtensionAccess().getHelpSTRINGTerminalRuleCall_12_1_0()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__HelpAssignment_12_1"


    // $ANTLR start "rule__AlExtension__UrlAssignment_13_1"
    // InternalMdal.g:2083:1: rule__AlExtension__UrlAssignment_13_1 : ( RULE_STRING ) ;
    public final void rule__AlExtension__UrlAssignment_13_1() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:2087:1: ( ( RULE_STRING ) )
            // InternalMdal.g:2088:2: ( RULE_STRING )
            {
            // InternalMdal.g:2088:2: ( RULE_STRING )
            // InternalMdal.g:2089:3: RULE_STRING
            {
             before(grammarAccess.getAlExtensionAccess().getUrlSTRINGTerminalRuleCall_13_1_0()); 
            match(input,RULE_STRING,FOLLOW_2); 
             after(grammarAccess.getAlExtensionAccess().getUrlSTRINGTerminalRuleCall_13_1_0()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__UrlAssignment_13_1"


    // $ANTLR start "rule__AlExtension__ContextSensitiveHelpUrlAssignment_14_1"
    // InternalMdal.g:2098:1: rule__AlExtension__ContextSensitiveHelpUrlAssignment_14_1 : ( RULE_STRING ) ;
    public final void rule__AlExtension__ContextSensitiveHelpUrlAssignment_14_1() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:2102:1: ( ( RULE_STRING ) )
            // InternalMdal.g:2103:2: ( RULE_STRING )
            {
            // InternalMdal.g:2103:2: ( RULE_STRING )
            // InternalMdal.g:2104:3: RULE_STRING
            {
             before(grammarAccess.getAlExtensionAccess().getContextSensitiveHelpUrlSTRINGTerminalRuleCall_14_1_0()); 
            match(input,RULE_STRING,FOLLOW_2); 
             after(grammarAccess.getAlExtensionAccess().getContextSensitiveHelpUrlSTRINGTerminalRuleCall_14_1_0()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__ContextSensitiveHelpUrlAssignment_14_1"


    // $ANTLR start "rule__AlExtension__ShowMyCodeAssignment_15_1"
    // InternalMdal.g:2113:1: rule__AlExtension__ShowMyCodeAssignment_15_1 : ( ruleBool ) ;
    public final void rule__AlExtension__ShowMyCodeAssignment_15_1() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:2117:1: ( ( ruleBool ) )
            // InternalMdal.g:2118:2: ( ruleBool )
            {
            // InternalMdal.g:2118:2: ( ruleBool )
            // InternalMdal.g:2119:3: ruleBool
            {
             before(grammarAccess.getAlExtensionAccess().getShowMyCodeBoolEnumRuleCall_15_1_0()); 
            pushFollow(FOLLOW_2);
            ruleBool();

            state._fsp--;

             after(grammarAccess.getAlExtensionAccess().getShowMyCodeBoolEnumRuleCall_15_1_0()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__ShowMyCodeAssignment_15_1"


    // $ANTLR start "rule__AlExtension__RuntimeAssignment_16_1"
    // InternalMdal.g:2128:1: rule__AlExtension__RuntimeAssignment_16_1 : ( RULE_STRING ) ;
    public final void rule__AlExtension__RuntimeAssignment_16_1() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:2132:1: ( ( RULE_STRING ) )
            // InternalMdal.g:2133:2: ( RULE_STRING )
            {
            // InternalMdal.g:2133:2: ( RULE_STRING )
            // InternalMdal.g:2134:3: RULE_STRING
            {
             before(grammarAccess.getAlExtensionAccess().getRuntimeSTRINGTerminalRuleCall_16_1_0()); 
            match(input,RULE_STRING,FOLLOW_2); 
             after(grammarAccess.getAlExtensionAccess().getRuntimeSTRINGTerminalRuleCall_16_1_0()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__AlExtension__RuntimeAssignment_16_1"


    // $ANTLR start "rule__TypeText__LengthAssignment_2_1"
    // InternalMdal.g:2143:1: rule__TypeText__LengthAssignment_2_1 : ( RULE_INT ) ;
    public final void rule__TypeText__LengthAssignment_2_1() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:2147:1: ( ( RULE_INT ) )
            // InternalMdal.g:2148:2: ( RULE_INT )
            {
            // InternalMdal.g:2148:2: ( RULE_INT )
            // InternalMdal.g:2149:3: RULE_INT
            {
             before(grammarAccess.getTypeTextAccess().getLengthINTTerminalRuleCall_2_1_0()); 
            match(input,RULE_INT,FOLLOW_2); 
             after(grammarAccess.getTypeTextAccess().getLengthINTTerminalRuleCall_2_1_0()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__TypeText__LengthAssignment_2_1"


    // $ANTLR start "rule__IdRange__MinAssignment_0"
    // InternalMdal.g:2158:1: rule__IdRange__MinAssignment_0 : ( RULE_INT ) ;
    public final void rule__IdRange__MinAssignment_0() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:2162:1: ( ( RULE_INT ) )
            // InternalMdal.g:2163:2: ( RULE_INT )
            {
            // InternalMdal.g:2163:2: ( RULE_INT )
            // InternalMdal.g:2164:3: RULE_INT
            {
             before(grammarAccess.getIdRangeAccess().getMinINTTerminalRuleCall_0_0()); 
            match(input,RULE_INT,FOLLOW_2); 
             after(grammarAccess.getIdRangeAccess().getMinINTTerminalRuleCall_0_0()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__IdRange__MinAssignment_0"


    // $ANTLR start "rule__IdRange__MaxAssignment_1_1"
    // InternalMdal.g:2173:1: rule__IdRange__MaxAssignment_1_1 : ( RULE_INT ) ;
    public final void rule__IdRange__MaxAssignment_1_1() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalMdal.g:2177:1: ( ( RULE_INT ) )
            // InternalMdal.g:2178:2: ( RULE_INT )
            {
            // InternalMdal.g:2178:2: ( RULE_INT )
            // InternalMdal.g:2179:3: RULE_INT
            {
             before(grammarAccess.getIdRangeAccess().getMaxINTTerminalRuleCall_1_1_0()); 
            match(input,RULE_INT,FOLLOW_2); 
             after(grammarAccess.getIdRangeAccess().getMaxINTTerminalRuleCall_1_1_0()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__IdRange__MaxAssignment_1_1"

    // Delegated rules


 

    public static final BitSet FOLLOW_1 = new BitSet(new long[]{0x0000000000000000L});
    public static final BitSet FOLLOW_2 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_3 = new BitSet(new long[]{0x0000000000002002L});
    public static final BitSet FOLLOW_4 = new BitSet(new long[]{0x0000000000000010L});
    public static final BitSet FOLLOW_5 = new BitSet(new long[]{0x0000000000004000L});
    public static final BitSet FOLLOW_6 = new BitSet(new long[]{0x00000001FFE38000L});
    public static final BitSet FOLLOW_7 = new BitSet(new long[]{0x0000000000040000L});
    public static final BitSet FOLLOW_8 = new BitSet(new long[]{0x0000000000000020L});
    public static final BitSet FOLLOW_9 = new BitSet(new long[]{0x0000000000080000L});
    public static final BitSet FOLLOW_10 = new BitSet(new long[]{0x0000000000100000L});
    public static final BitSet FOLLOW_11 = new BitSet(new long[]{0x0000000000100002L});
    public static final BitSet FOLLOW_12 = new BitSet(new long[]{0x0000000000001800L});
    public static final BitSet FOLLOW_13 = new BitSet(new long[]{0x0000000200000000L});
    public static final BitSet FOLLOW_14 = new BitSet(new long[]{0x0000000400000000L});

}