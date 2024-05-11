const got = require('got');

class CommonGotApi {
  static async fetchDataWithRetryGet(apiUrl, apiKey, params) {
    let retryCount = 1;
    let computedValue = 4;
    let maxRetry = 4;

    const headers = {
      Authorization: `Bearer ${apiKey}`,
      'Content-Type': 'application/json'
    };

    try {
      const response = await got.get(apiUrl, {
        searchParams: params,
        headers: headers,
        retry: {
          limit: 3,
          methods: ['GET'],
          statusCodes: [429],
          errorCodes: [
            'ETIMEDOUT',
            'ECONNRESET',
            'EADDRINUSE',
            'ECONNREFUSED',
            'EPIPE',
            'ENETUNREACH',
            'EAI_AGAIN',
            'EPROTO',
          ],
          calculateDelay: () => {
            computedValue *= 2 ** retryCount;
            retryCount += 1;
            console.log('Retry API after', computedValue, 'seconds. Retry count:', retryCount);
            if (retryCount > maxRetry) return 0;
            return computedValue * 1000;
          },
        },
        responseType: 'json'
      });

      return response?.body;
    } catch (error) {
      throw new Error(`Error fetching data: ${error.message}`);
    }
  }
}

module.exports = CommonGotApi;
