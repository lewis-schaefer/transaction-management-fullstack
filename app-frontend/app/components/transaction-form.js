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

    if (amount === '0') {
      console.error('Invalid amount: cannot be 0');
      return;
    }

    const url = `http://localhost:8080/api/v1/transactions`;

    const response = await fetch(url, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        account_id: accountId,
        amount: amount,
      }),
    });

    if (response.ok) {
      event.target.reset();
      await this.store.findAll('transaction');
    } else {
      event.target.reset();
      const errorData = await response;
      console.error('Transaction failed:', errorData);
    }
  }
  catch(error) {
    console.error('Save transaction failed:', error);
  }
}
