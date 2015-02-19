package org.casualintellect.editor.tests

import com.google.inject.Inject
import org.casualintellect.CasualIntellectInjectorProvider
import org.eclipse.xtext.junit4.InjectWith
import org.eclipse.xtext.junit4.XtextRunner
import org.eclipse.xtext.xbase.compiler.CompilationTestHelper
import org.eclipse.xtext.xbase.lib.util.ReflectExtensions
import org.junit.Test
import org.junit.runner.RunWith

@RunWith(typeof(XtextRunner))
@InjectWith(typeof(CasualIntellectInjectorProvider))
class GeneratorTest {
		

	@Inject extension CompilationTestHelper
	@Inject extension ReflectExtensions

	@Test
	def void testGeneratedCode() {

		'''state state1{
			before: salo, pivo, vodka;
		    after:salo,pivo,vodka; 
		    in_process:pivo, vodka, salo; 
		    transitions: {transition:salo; condition:f1 || f2&&!false} 
		  }'''.
			assertCompilesTo(
				'''<state name="state1">
	<before methods="salo,pivo,vodka"/>
	<after methods="salo,pivo,vodka"/>	
	<in_process methods="pivo,vodka,salo"/>
	<transitions>
	<transition name="salo" methods="">
		<condition function="f1 || f2 && false"/>
	</transition>
	</transitions>
</state>
''')
	}
	
@Test
	def void testMethodsInTransition() {

		'''state state1{
			before: salo, pivo, vodka;
		    after:salo,pivo,vodka; 
		    in_process:pivo, vodka, salo; 
		    transitions: {transition:salo; condition:f1 || f2&&!false;methods:salo,pivo,vodka} 
		  }'''.
			assertCompilesTo(
				'''<state name="state1">
	<before methods="salo,pivo,vodka"/>
	<after methods="salo,pivo,vodka"/>	
	<in_process methods="pivo,vodka,salo"/>
	<transitions>
	<transition name="salo" methods="salo,pivo,vodka">
		<condition function="f1 || f2 && false"/>
	</transition>
	</transitions>
</state>
''')
	}	
@Test
def void testWithBrackets() {

		'''state state1{
			before: salo, pivo, vodka;
		    after:salo,pivo,vodka; 
		    in_process:pivo, vodka, salo; 
		    transitions: {transition:salo; condition:(f1 || f2)&&!false} 
		  }'''.
			assertCompilesTo(
				'''<state name="state1">
	<before methods="salo,pivo,vodka"/>
	<after methods="salo,pivo,vodka"/>	
	<in_process methods="pivo,vodka,salo"/>
	<transitions>
	<transition name="salo" methods="">
		<condition function="(f1 || f2) && false"/>
	</transition>
	</transitions>
</state>
''')
	}
@Test
def void testTwoTransitions() {

		'''state state1{
			before: salo, pivo, vodka;
		    after:salo,pivo,vodka; 
		    in_process:pivo, vodka, salo; 
		    transitions: {transition:salo; condition:(f1 || f2)&&!false, transition:pivo; condition:(f1 || f2)&&!false} 
		  }'''.
			assertCompilesTo(
				'''<state name="state1">
	<before methods="salo,pivo,vodka"/>
	<after methods="salo,pivo,vodka"/>	
	<in_process methods="pivo,vodka,salo"/>
	<transitions>
	<transition name="salo" methods="">
		<condition function="(f1 || f2) && false"/>
	</transition>
	<transition name="pivo" methods="">
		<condition function="(f1 || f2) && false"/>
	</transition>
	</transitions>
</state>
''')
	}

}
