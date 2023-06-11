import http from 'k6/http';
import { check } from 'k6';

const url = 'http://127.0.0.1:8080/authors/1/books';

export const options = {
    stages: [
        { duration: '10s', target: 2000 },
        { duration: '1s', target: 0 },
    ],
};

export default function () {
    let book = {
        title: 'Book Title',
        summary: 'Book summary in a few words',
        publication_date: '2021-01-01'
    };

    let res = http.post(url, JSON.stringify(book), {
        headers: { 'Content-Type': 'application/json' },
    });
    check(res, { 'status was 200': (r) => r.status == 200 });
}

// vim: sw=4:et:ai
