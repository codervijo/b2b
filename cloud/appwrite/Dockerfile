# Start from Ubuntu 22.04
FROM ubuntu:22.04

# Set non-interactive mode for apt
ENV DEBIAN_FRONTEND=noninteractive

# Update and install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    gnupg \
    software-properties-common \
    lsb-release \
    postgresql \
    postgresql-contrib \
    && rm -rf /var/lib/apt/lists/*

# # Install Node.js 18.x and pnpm
# RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
#     apt-get install -y nodejs && \
#     npm install -g pnpm

# # Set environment variables for PostgreSQL
# ENV POSTGRES_USER=postgres
# ENV POSTGRES_PASSWORD=supabase
# ENV POSTGRES_DB=postgres

# # Configure PostgreSQL to enable extensions
# RUN echo "shared_preload_libraries = 'pg_stat_statements,pgcrypto'" >> /etc/postgresql/14/main/postgresql.conf

RUN apt-get update && apt-get install -y git vim net-tools
# # Download and install Supabase Studio
# RUN mkdir -p /opt/supabase-studio && \
#     cd /opt/supabase-studio && \
#     pnpm add supabase/studio && \
#     pnpm run build

# # Expose PostgreSQL and Supabase Studio ports
# EXPOSE 5432 3000

# # Copy entrypoint script
# COPY entrypoint.sh /usr/local/bin/
# RUN chmod +x /usr/local/bin/entrypoint.sh

# # Set the entrypoint
# ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

