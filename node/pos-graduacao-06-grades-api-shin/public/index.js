(() => {
  const form = document.getElementsByTagName('form')[0];
  const list = document.getElementsByTagName('ul')[0];

  form.addEventListener('submit', submitHandler);

  function submitHandler(event) {
    event.preventDefault();
    const { student, subject, type, value } = form.getElementsByTagName('input');
    const body = {
      student: student.value,
      subject: subject.value,
      type: type.value,
      value: value.value,
    };

    const fetchArg = getFetchArgs({ method: 'POST', body });

    console.log(event);

    fetch('http://localhost:9000/grades', fetchArg).then((res) => {
      if (res.ok) {
        window.location.reload();
      }
    });
  }

  function createList(htmlToInject, page) {
    fetch('http://localhost:9000/grades?limit=1000')
      .then((res) => res.json())
      .then((res) => {
        const appendHTML = res.docs
          .map(
            (doc) =>
              `<li><span>${doc.student}</span><span>${doc.subject}</span><span>${doc.type}</span><span>${doc.value}</span><button type="button" data-id="${doc._id}" >Remover</button></li>`,
          )
          .join('');
        list.innerHTML += appendHTML;

        addRemoveButtonEvent();
      });
  }

  createList(list);

  function addRemoveButtonEvent() {
    const buttonList = [...list.getElementsByTagName('button')];
    buttonList.map((button) =>
      button.addEventListener('click', () => buttonRemove(button.dataset.id)),
    );
  }

  function buttonRemove(id) {
    if (!id) return;

    const fetchArg = getFetchArgs({ method: 'DELETE' });

    fetch(`http://localhost:9000/grades/${id}`, fetchArg).then((res) => {
      if (res.ok) {
        window.location.reload();
      }
    });
  }

  function getFetchArgs({
    method = 'GET',
    mode = 'cors',
    cache = 'no-cache',
    credentials = 'same-origin',
    headers = {
      'Content-Type': 'application/json',
    },
    referrerPolicy = 'no-referrer',
    body,
  }) {
    const result = {
      method,
      mode,
      cache,
      credentials,
      headers,
      referrerPolicy,
    };

    if (body) {
      result.body = JSON.stringify(body);
    }

    return result;
  }
})();
