/**
 * Implementa a Opera��o de Potencia
 *
 */
public class Potencia extends Operacoes {

	/**
	 * Implementa a Potencia
	 */
	public float calculaOperacao(float operando1, float operando2) {
		float resultado; //Vari�vel que guardar� o resultado.
		
		resultado= Math.pow(operando1, operando2); //realiza a conta
		
		return resultado;
	}

}
