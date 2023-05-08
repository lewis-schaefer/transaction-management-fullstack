import { helper } from '@ember/component/helper';

export function isNegative(params) {
  const amount = params[0];

  const numberAmount = parseFloat(amount);

  return numberAmount < 0;
}

export default helper(isNegative);
