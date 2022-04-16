import React from "react";

export interface HomeProps {}

const Home: React.FunctionComponent<HomeProps> = () => {
    return (
        <div>
            <nav>
                <div>disciplina atual</div>
                <div>botoes de pagina</div>
                <div>botao de profile</div>
            </nav>

            <div>
                <div>livro</div>
                <div>video conceitual</div>
                <div>aulas ao vivo</div>
                <div>atividades</div>
                <div>mapa</div>
                <div>prova</div>
            </div>
        </div>
    );
};

export default Home;
