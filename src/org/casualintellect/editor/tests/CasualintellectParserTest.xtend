package org.casualintellect.editor.tests

import com.google.inject.Inject
import org.casualintellect.CasualIntellectInjectorProvider
import org.casualintellect.casualIntellect.Model
import org.eclipse.xtext.junit4.InjectWith
import org.eclipse.xtext.junit4.XtextRunner
import org.eclipse.xtext.junit4.util.ParseHelper
import org.eclipse.xtext.junit4.validation.ValidationTestHelper
import org.eclipse.xtext.xbase.compiler.CompilationTestHelper
import org.junit.Test
import org.junit.runner.RunWith

@RunWith(typeof(XtextRunner))
@InjectWith(typeof(CasualIntellectInjectorProvider))
class CasualintellectParserTest {
	@Inject extension ParseHelper<Model>
	@Inject extension ValidationTestHelper
	

	@Test def void testEmptyTransitions() {
		'''state state1{
			before: salo, pivo, vodka;
		    after:salo,pivo,vodka; 
		    in_process:pivo, vodka, salo; 
		 }'''.
			parse.assertNoErrors;
	}

	@Test def void testTransition() {
		'''state state1{
			before: salo, pivo, vodka;
		    after:salo,pivo,vodka; 
		    in_process:pivo, vodka, salo; 
		    transitions : {transition:salo; condition:true; methods:salo,pivo,vodka} 
		  }'''.
			parse.assertNoErrors;
	}

	@Test def void testEmptyTransitionMethods() {
		'''state state1{
			before: salo, pivo, vodka;
		    after:salo,pivo,vodka; 
		    in_process:pivo, vodka, salo; 
		    transitions : {transition:salo; condition:true} 
		  }'''.
			parse.assertNoErrors;
	}

	@Test def void testTransitionExpression() {
			'''state state1{
			   	before: salo, pivo, vodka;
			   	after:salo,pivo,vodka; 
			   	in_process:pivo, vodka, salo; 
			   	transitions : {transition:salo; condition:f1 || f2&&f3} 
	}'''.
			parse.assertNoErrors;
	}

	@Test def void testStateWithoutBefore() {
		'''state state1{
			before:;
			after:salo,pivo,vodka; 
		   	in_process:pivo, vodka, salo; 
		   	transitions : {transition:salo; condition:f1 || f2&&f3} 
}'''.
			parse.assertNoErrors;
	}

	@Test def void testEmptyState() {
		'''state state1{
			before:pivo;
			after:salo;
			in_process:vodka;
			transitions : {transition:salo; condition:f1 || f2&&f3} 
			}'''.parse.assertNoErrors;
	}

	@Test def void testTransitionExpressionWithNot() {
		'''state state1{
			before: salo, pivo, vodka;
		    after:salo,pivo,vodka; 
		    in_process:pivo, vodka, salo; 
		    transitions: {transition:salo; condition:f1 || f2&&!false} 
		  }'''.
			parse.assertNoErrors;
	}

	

}
