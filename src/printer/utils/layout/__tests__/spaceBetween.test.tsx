import { spaceBetween } from '../spaceBetween';

describe('spaceBetween', () => {
  it('should create line with text on the text and on the right', () => {
    const res = spaceBetween(20, {
      left: 'Cheesburger',
      right: '2$',
    });

    expect(res).toBe('Cheesburger       2$');
  });

  it('should wrap left text', () => {
    const res = spaceBetween(25, {
      left: 'Cheesburger, Hamburger, Chicken Mac',
      right: '45.00 EUR',
      textToWrap: 'left',
    });

    expect(res).toBe(
      [
        'Cheesburger,    45.00 EUR',
        'Hamburger,               ',
        'Chicken Mac              ',
      ].join('\n')
    );
  });

  it('should wrap right text', () => {
    const res = spaceBetween(25, {
      left: '45.00 EUR',
      right: 'Cheesburger, Hamburger, Chicken Mac',
      textToWrap: 'right',
    });

    expect(res).toBe(
      [
        '45.00 EUR    Cheesburger,',
        '               Hamburger,',
        '              Chicken Mac',
      ].join('\n')
    );
  });

  it('should add custom gap symbol if needed', () => {
    const res = spaceBetween(25, {
      left: 'Cheesburger',
      right: '45.00 EUR',
      gapSymbol: '.',
    });

    expect(res).toBe('Cheesburger.....45.00 EUR');
  });

  it('should wrap left text with custom width', () => {
    const res = spaceBetween(25, {
      left: 'Cheesburger, Hamburger, Chicken Mac',
      right: '45.00 EUR',
      textToWrap: 'left',
      textToWrapWidth: 0.3,
    });

    expect(res).toBe(
      [
        'Cheesbu         45.00 EUR',
        'rger,                    ',
        'Hamburg                  ',
        'er,                      ',
        'Chicken                  ',
        'Mac                      ',
      ].join('\n')
    );
  });

  it('should wrap both if main text length more then max length', () => {
    const res = spaceBetween(16, {
      left: 'Cheesburger, Hamburger, Chicken Mac',
      right: '45.00 EUR',
      textToWrap: 'right',
    });

    expect(res).toBe(
      [
        'Cheesbur   45.00',
        'ger,         EUR',
        'Hamburge        ',
        'r,              ',
        'Chicken         ',
        'Mac             ',
      ].join('\n')
    );
  });
});
