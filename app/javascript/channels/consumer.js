import "actioncable";

const consumer = globalThis.ActionCable.createConsumer("/cable");

export default consumer;
