import http from 'k6/http';
import { check, sleep } from 'k6';

const url = 'http://127.0.0.1:8080/authors';

export const options = {
    stages: [
        { duration: '10s', target: 2000 },
        { duration: '1s', target: 0 },
    ],
};

export default function () {
    const res = http.get(url);
    check(res, { 'status was 200': (r) => r.status == 200 });
    // sleep(1);
}

// vim: sw=4:et:ai
