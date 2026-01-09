FROM node:7.8.0

WORKDIR /opt

# Copy package files
COPY package.json .

# Increase network resilience and install
RUN npm config set fetch-retries 5 && \
    npm install --production --quiet

# Copy the rest
COPY . .

EXPOSE 3000

ENTRYPOINT ["npm", "run", "start"]