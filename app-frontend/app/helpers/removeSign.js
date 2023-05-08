import { helper } from '@ember/component/helper';

export function removeSign(params) {
  const value = params[0];
  // console.log(typeof value);

  if (typeof value === 'number') {
    return Math.abs(value);
  }
}

export default helper(removeSign);
