import Component from '@glimmer/component';
import { action } from '@ember/object';
import { inject as service } from '@ember/service';
import fetch from 'fetch';

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

    const url = `http://localhost:8080/api/v1/transactions`;

    const response = await fetch(url, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        accountId,
        amount,
      }),
    });

    if (response.ok) {
      await this.store.findAll('transaction');
    } else {
      const errorData = await response;
      console.error('Transaction failed:', errorData);
    }
  }
  // catch(error) {
  //   console.error('Save transaction failed:', error);
  // }
}
