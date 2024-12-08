
import openai from 'openai';

openai.apiKey = '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';

export const getCompletion = async (prompt, temperature = 0) => {
    const response = await openai.createChatCompletion({
        model: 'gpt-3.5-turbo',
        messages: [
            { role: 'user', content: prompt },
        ],
        temperature // Degree of randomness of the model's output
    })

    return response.data.choices[0].message.content
}

export default getCompletionFromMessages = async (messages, temperature = 0) => {
    const response = await openai.createChatCompletion({
        model: 'gpt-3.5-turbo',
        messages,
        temperature
    })

    return response.data.choices[0].message.content
}