import {
  NativeModules,
  EmitterSubscription,
  NativeEventEmitter,
} from 'react-native';

import lineWrap from 'word-wrap';
import {
  PRINTING_ALIGNMENT,
  PRINTING_COMMANDS,
  EPOS_BOOLEANS,
} from './constants';
import type { IMonitorStatus } from './types';
import { BufferHelper } from './utils/BufferHelper';

const { EscPosPrinter } = NativeModules;
const printEventEmmiter = new NativeEventEmitter(EscPosPrinter);

type TCommandValue = [string, any[]];
type TScalingFactors = 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8;

/**
 * Create an array of commands to send to the printer
 */
class Printing {
  private _buffer: any[];
  private _state: {
    bold: boolean;
    underline: boolean;
    smooth: boolean;
  };

  /**
   * Create a new object
   *
   */
  constructor() {
    this._buffer = [];
    this._state = {
      bold: false,
      underline: false,
      smooth: false,
    };
  }

  /**
   * Reset the state of the object
   *
   */
  _reset() {
    this._buffer = [];

    this._state = {
      bold: false,
      underline: false,
      smooth: false,
    };
  }

  /**
   * Send the current array of commands to the printer
   *
   * @param  {string}   value  String to encode
   * @return {object}          Encoded string as a ArrayBuffer
   *
   */
  _send(value: any): Promise<IMonitorStatus> {
    let successListener: EmitterSubscription | null;
    let errorListener: EmitterSubscription | null;

    function removeListeners() {
      successListener?.remove();
      errorListener?.remove();

      successListener = null;
      errorListener = null;
    }

    return new Promise((res, rej) => {
      successListener = printEventEmmiter.addListener(
        'onPrintSuccess',
        (status) => {
          removeListeners();
          res(status);
        }
      );

      errorListener = printEventEmmiter.addListener(
        'onPrintFailure',
        (status) => {
          removeListeners();
          rej(status);
        }
      );

      EscPosPrinter.printBuffer(value).catch((e: Error) => {
        removeListeners();
        rej(e);
      });
    });
  }

  /**
   * Add a command to the buffer
   *
   * @param  {array}   value  Array containing the command to call and parameters
   *
   */
  _queue(value: TCommandValue) {
    this._buffer.push(value);
  }

  /**
   * Initialize the printer
   *
   * @return {object}          Return the object, for easy chaining commands
   *
   */
  initialize() {
    this._reset();

    return this;
  }

  /**
   * Print text
   *
   * @param  {string}   value  Text that needs to be printed
   * @param  {number}   wrap   Wrap text after this many positions
   * @return {object}          Return the object, for easy chaining commands
   *
   */
  text(value: string, wrap?: lineWrap.IOptions) {
    if (wrap) {
      value = lineWrap(value, wrap);
    }

    this._queue([PRINTING_COMMANDS.COMMAND_ADD_TEXT, [value]]);

    return this;
  }

  /**
   * Print a newline
   *
   * @param {number}   value   Number of lines to add
   * @return {object}          Return the object, for easy chaining commands
   *
   */
  newline(value?: number) {
    this._queue([PRINTING_COMMANDS.COMMAND_ADD_NEW_LINE, [value || 1]]);

    return this;
  }

  /**
   * Print text, followed by a newline
   *
   * @param  {string}   value  Text that needs to be printed
   * @param  {number}   wrap   Wrap text after this many positions
   * @return {object}          Return the object, for easy chaining commands
   *
   */
  line(value: string, wrap?: lineWrap.IOptions) {
    this.text(value, wrap);
    this.newline();

    return this;
  }

  /**
   * Underline text
   *
   * @param  {boolean}   value  true to turn on underline, false to turn off, or 2 for double underline
   * @return {object}           Return the object, for easy chaining commands
   *
   */
  underline(value?: boolean) {
    if (typeof value === 'undefined') {
      value = !this._state.underline;
    }

    this._state.underline = value;

    this._queue([
      PRINTING_COMMANDS.COMMAND_ADD_TEXT_STYLE,
      [
        this._convertToEposBool(this._state.underline),
        this._convertToEposBool(this._state.bold),
      ],
    ]);

    return this;
  }

  /**
   * Convert To Esc Pos Bool
   *
   * @param value boolean value to change
   * @returns The equivalent esc pos boolean
   */
  _convertToEposBool(value: boolean) {
    const res = value ? EPOS_BOOLEANS.EPOS2_TRUE : EPOS_BOOLEANS.EPOS2_FALSE;

    return res;
  }

  /**
   * Bold text
   *
   * @param  {boolean}          value  true to turn on bold, false to turn off bold
   * @return {object}                  Return the object, for easy chaining commands
   *
   */
  bold(value?: boolean) {
    if (typeof value === 'undefined') {
      value = !this._state.bold;
    }

    this._state.bold = value;

    this._queue([
      PRINTING_COMMANDS.COMMAND_ADD_TEXT_STYLE,
      [
        this._convertToEposBool(this._state.underline),
        this._convertToEposBool(this._state.bold),
      ],
    ]);

    return this;
  }

  /**
   * Smooth text
   *
   * @param  {boolean}          value  true to turn on smooth, false to turn off smooth
   * @return {object}                  Return the object, for easy chaining commands
   *
   */
  smooth(value?: boolean) {
    if (typeof value === 'undefined') {
      value = !this._state.smooth;
    }

    this._state.smooth = value;

    this._queue([
      PRINTING_COMMANDS.COMMAND_ADD_TEXT_SMOOTH,
      [this._convertToEposBool(this._state.smooth)],
    ]);

    return this;
  }

  /**
   * Change text size
   *
   * @param  {number} height Specifies the vertical scaling factor rate
   * @param  {number} width Specifies the horizontal scaling factor rate
   * @return {object} Return the object, for easy chaining commands
   *
   */
  size(height: TScalingFactors, width?: TScalingFactors) {
    if (typeof width === 'undefined') {
      width = height;
    }

    this._queue([
      PRINTING_COMMANDS.COMMAND_ADD_TEXT_SIZE,
      [height || 1, width || 1],
    ]);

    return this;
  }

  /**
   * Change text alignment
   *
   * @param  {string} value left, center or right
   * @return {object} Return the object, for easy chaining commands
   *
   */
  align(value: 'left' | 'center' | 'right') {
    if (!['left', 'center', 'right'].includes(value)) {
      throw new Error('Unknown alignment');
    }

    this._queue([
      PRINTING_COMMANDS.COMMAND_ADD_ALIGN,
      [PRINTING_ALIGNMENT[value]],
    ]);

    return this;
  }

  /**
   * Image
   *
   * @param {string} image base64encoded image string
   * @param {number} width Width of the image 1 to 65535
   * @returns
   */
  imageBase64(image: string, width: number) {
    this._queue([PRINTING_COMMANDS.COMMAND_ADD_IMAGE_BASE_64, [image, width]]);

    return this;
  }

  /**
   * Image
   *
   * @param {string} image image asset name string
   * @returns
   */
  imageAsset(image: string, width?: number) {
    this._queue([PRINTING_COMMANDS.COMMAND_ADD_IMAGE_ASSET, [image, width]]);

    return this;
  }

  /**
   * Cut paper
   *
   * @return {object} Return the object, for easy chaining commands
   *
   */
  cut() {
    this._queue([PRINTING_COMMANDS.COMMAND_ADD_CUT, []]);

    return this;
  }

  /**
   * Cut paper
   *
   * @return {object} Return the object, for easy chaining commands
   *
   */
  data(uint8Array: Uint8Array) {
    const buffer = new BufferHelper();
    const base64String = buffer.bytesToString(uint8Array, 'base64');
    this._queue([PRINTING_COMMANDS.COMMAND_ADD_DATA, [base64String]]);

    return this;
  }

  send() {
    return this._send(this._buffer);
  }
}

export default Printing;
