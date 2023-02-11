import React from 'react'

const CompanyCard = () => {
  return (
    <div>
        <div className="card">
        <div className="card__image">
          <img src="https://images.unsplash.com/photo-1521139869420-edaae1bc7b9a?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=400&fit=max&ixid=eyJhcHBfaWQiOjE0NTg5fQ" />
        </div>
        <div className="card__copy">
            <h1>Robin Hood's Bay</h1>
            <h2>27 October, Noon.</h2>
          <p>
            --Most strange; no news yet of the ship we wait for. Mrs. Harker
            reported last night and this morning as usual: "lapping waves and
            rushing water," though she added that "the waves were very faint."
            The telegrams from London have been the same: "no further report."
            Van Helsing is terribly anxious, and told me just now that he fears
            the Count is escaping us. He added significantly:--
          </p>
        </div>
      </div>
    </div>
  )
}

export default CompanyCard