import { LightningElement, wire } from 'lwc';
import getAnimalList from '@salesforce/apex/ConsumindoApiAnimais.usoLWC';

export default class ToAPI extends LightningElement {
    animals;
    error;

    connectedCallback() { //chama o loadAnimals assim que o componente inicia.
        this.loadAnimals();
    }

    async loadAnimals() {
        try {
            this.animals = await getAnimalList();
            this.error = undefined;
            console.log('Animais: '+this.animals);
        } catch (error) {
            this.animals = undefined;
            this.error = error;
            console.log('Erro:'+error.message);
        }
    }
}
