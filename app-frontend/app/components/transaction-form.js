import Component from '@glimmer/component';
import { action } from '@ember/object';
import { inject as service } from '@ember/service';


export default class TransactionFormComponent extends Component {
  @service store;

  @action
  async submitTransaction(event) {
    event.preventDefault();
    // console.log(event);
    // console.log(event.target.elements.amount.value);
    // console.log(event.target.elements['account-id'].value);

    const accountId = event.target.elements['account-id'].value;
    const amount = event.target.elements.amount.value;
  }
}
