CREATE TABLE security_events (
    id UUID PRIMARY KEY,
    event_type VARCHAR(100) NOT NULL,
    event_category VARCHAR(50) NOT NULL,
    realm_id UUID NOT NULL REFERENCES realms(id) ON DELETE CASCADE,
    user_id UUID REFERENCES users(id) ON DELETE SET NULL,
    client_id UUID REFERENCES clients(id) ON DELETE SET NULL,
    ip_address INET,
    user_agent TEXT,
    event_data JSONB,
    success BOOLEAN NOT NULL DEFAULT TRUE,
    error_message TEXT,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_security_events_realm_created ON security_events(realm_id, created_at DESC);
CREATE INDEX idx_security_events_user_id ON security_events(user_id) WHERE user_id IS NOT NULL;
CREATE INDEX idx_security_events_event_type ON security_events(event_type);